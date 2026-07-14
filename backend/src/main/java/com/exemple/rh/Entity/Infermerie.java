package com.exemple.rh.Entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class Infermerie {




    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Employe employe;

    private LocalDate date;


    private String type; // exemple: "Sortie", "Arrêt", "Consultation"
    private String motif; // exemple: "Douleur", "Accident", "Fatigue", etc.

    private String statut = "En attente"; // "En attente", "Validée", "Refusée"

    // Getters et Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }



    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
}

