package com.exemple.rh.Repository;

import com.exemple.rh.Entity.Employe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EmployeRepository extends JpaRepository<Employe, Long> {
    Optional<Employe> findByMatricule(String matricule);
    boolean existsByMatricule(String matricule);
    List<Employe> findByZone(String zone);
    List<Employe> findByRoleContaining(String role);
}

