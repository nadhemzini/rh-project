package com.exemple.rh.Service;

import com.exemple.rh.Entity.Employe;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.junit.jupiter.api.Test;

import java.lang.reflect.Field;
import java.security.Key;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class JwtServiceTest {

    private final JwtService jwtService = new JwtService();

    @Test
    void generateTokenCopiesSubjectAndRoleClaims() throws Exception {
        Employe employe = new Employe();
        employe.setMatricule("EMP-001");
        employe.setRole("ADMIN");

        Claims claims = parseClaims(jwtService.generateToken(employe));

        assertEquals("EMP-001", claims.getSubject());
        assertEquals("ADMIN", claims.get("role", String.class));
        assertNotNull(claims.getIssuedAt());
        assertNotNull(claims.getExpiration());
    }

    @Test
    void generateTokenSetsExpirationAboutTenHoursAhead() throws Exception {
        Employe employe = new Employe();
        employe.setMatricule("EMP-002");
        employe.setRole("USER");

        Claims claims = parseClaims(jwtService.generateToken(employe));
        long lifetimeMillis = claims.getExpiration().getTime() - claims.getIssuedAt().getTime();

        assertTrue(lifetimeMillis >= 9L * 60 * 60 * 1000, "Token lifetime should be close to 10 hours");
        assertTrue(lifetimeMillis <= 10L * 60 * 60 * 1000 + 5_000L, "Token lifetime should not exceed 10 hours by much");
    }

    private Claims parseClaims(String token) throws Exception {
        return Jwts.parserBuilder()
                .setSigningKey(signingKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private Key signingKey() throws Exception {
        Field field = JwtService.class.getDeclaredField("key");
        field.setAccessible(true);
        return (Key) field.get(null);
    }
}
