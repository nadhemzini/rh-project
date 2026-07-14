package com.exemple.rh.Entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class Conge {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDate dateDebut;
    private LocalDate dateFin;
    private String type; // exemple : "Annuel", "Maladie", etc.
    private String validationResponsableHierarchique = "En attente";
    private String validationResponsableRH = "En attente";

    // Champ global que tu peux calculer ou garder pour résumé
    private String statut = "En attente";

    private String motifRefus;

    @ManyToOne(fetch = FetchType.EAGER)
    private Employe employe;

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public LocalDate getDateDebut() {
        return dateDebut;
    }
    public void setDateDebut(LocalDate dateDebut) {
        this.dateDebut = dateDebut;
    }
    public LocalDate getDateFin() {
        return dateFin;
    }
    public void setDateFin(LocalDate dateFin) {
        this.dateFin = dateFin;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public String getStatut() {
        return statut;
    }
    public void setStatut(String statut) {
        this.statut = statut;
    }
    public Employe getEmploye() {
        return employe;
    }
    public void setEmploye(Employe employe) {
        this.employe = employe;
    }
    public String getValidationResponsableHierarchique() { return validationResponsableHierarchique; }
    public void setValidationResponsableHierarchique(String v) { this.validationResponsableHierarchique = v; }
    public String getValidationResponsableRH() { return validationResponsableRH; }
    public void setValidationResponsableRH(String v) { this.validationResponsableRH = v; }
    public String getMotifRefus() {
        return motifRefus;
    }

    public void setMotifRefus(String motifRefus) {
        this.motifRefus = motifRefus;
    }
}

