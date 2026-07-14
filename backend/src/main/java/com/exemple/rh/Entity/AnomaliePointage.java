package com.exemple.rh.Entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class AnomaliePointage {
    @Id
    @GeneratedValue
    private Long id;



    @Enumerated(EnumType.STRING)
    private TypeAnomalie typeAnomalie; // ENTREE ou SORTIE

    private String remarque;
    private LocalDate dateDemande;
    private String statut = "En attente"; // Acceptée ou Refusée

    public enum TypeAnomalie {
        ENTREE, SORTIE
    }
    @ManyToOne
    private Employe employe;


    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public TypeAnomalie getTypeAnomalie() {
        return typeAnomalie;
    }
    public void setTypeAnomalie(TypeAnomalie typeAnomalie) {
        this.typeAnomalie = typeAnomalie;
    }
    public String getRemarque() {
        return remarque;
    }
    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    public LocalDate getDateDemande() {
        return dateDemande;
    }
    public void setDateDemande(LocalDate dateDemande) {
        this.dateDemande = dateDemande;
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
}

