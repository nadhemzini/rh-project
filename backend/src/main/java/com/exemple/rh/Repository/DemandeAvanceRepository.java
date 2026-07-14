package com.exemple.rh.Repository;

import com.exemple.rh.Entity.AvanceSalaire;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DemandeAvanceRepository extends JpaRepository<AvanceSalaire, Long> {
    List<AvanceSalaire> findByEmployeMatricule(String matricule);
}

