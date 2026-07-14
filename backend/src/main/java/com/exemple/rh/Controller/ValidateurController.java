package com.exemple.rh.Controller;

import com.exemple.rh.Entity.ChangeValidateurDTO;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Service.ValidateurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/validateurs")
public class ValidateurController {

    @Autowired
    private ValidateurService validateurService;

    @GetMapping("/afficher")
    public ResponseEntity<?> getAllValidators(@RequestParam String role) {
        try {
            if (!"Responsable RH".equals(role)) {
                return ResponseEntity.status(403).body("Accès refusé. Seul le Responsable RH peut accéder à cette ressource.");
            }

            List<Map<String, Object>> validators = validateurService.getAllValidators();
            return ResponseEntity.ok(validators);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erreur lors de la récupération des validateurs: " + e.getMessage());
        }
    }

    @GetMapping("/employees-by-zone")
    public ResponseEntity<?> getEmployeesByZone(
            @RequestParam String zone,
            @RequestParam String role) {
        try {
            if (!"Responsable RH".equals(role)) {
                return ResponseEntity.status(403).body("Accès refusé. Seul le Responsable RH peut accéder à cette ressource.");
            }

            List<Employe> employees = validateurService.getEmployeesByZone(zone);
            return ResponseEntity.ok(employees);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erreur lors de la récupération des employés: " + e.getMessage());
        }
    }

    @PutMapping("/change")
    public ResponseEntity<?> changeValidator(
            @RequestBody ChangeValidateurDTO dto,
            @RequestParam String role) {
        try {
            if (!"Responsable RH".equals(role)) {
                return ResponseEntity.status(403).body("Accès refusé. Seul le Responsable RH peut effectuer cette opération.");
            }

            Map<String, Object> result = validateurService.changeValidator(dto);
            return ResponseEntity.ok(result);
        } catch (RuntimeException e) {
            return ResponseEntity.status(400).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erreur lors du changement de validateur: " + e.getMessage());
        }
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<?> toggleValidatorStatus(
            @PathVariable Long id,
            @RequestBody Map<String, Boolean> request,
            @RequestParam String role) {
        try {
            if (!"Responsable RH".equals(role)) {
                return ResponseEntity.status(403).body("Accès refusé. Seul le Responsable RH peut modifier le statut.");
            }

            Boolean active = request.get("active");
            if (active == null) {
                return ResponseEntity.status(400).body("Le champ 'active' est obligatoire.");
            }

            Employe employe = validateurService.toggleValidatorStatus(id, active);
            return ResponseEntity.ok(employe);
        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erreur lors de la mise à jour du statut: " + e.getMessage());
        }
    }
}
