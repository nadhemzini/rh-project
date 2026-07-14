package com.exemple.rh.Repository;

import com.exemple.rh.Entity.DemandeDocument;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DemandeDocumentRepository extends JpaRepository<DemandeDocument, Long> {
    List<DemandeDocument> findByEmployeMatricule(String matricule);
}

