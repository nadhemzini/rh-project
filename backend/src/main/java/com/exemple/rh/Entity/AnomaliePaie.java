package com.exemple.rh.Entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class AnomaliePaie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String description;
    private LocalDate dateAnomalie;
    private String typeAnomalie;
    @ManyToOne
    private Employe employe;
    private String statut = "En attente"; // valeur par défaut

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public LocalDate getDateAnomalie() {
        return dateAnomalie;
    }
    public void setDateAnomalie(LocalDate dateAnomalie) {
        this.dateAnomalie = dateAnomalie;
    }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
    public String getTypeAnomalie() {
        return typeAnomalie;
    }

    public void setTypeAnomalie(String typeAnomalie) {
        this.typeAnomalie = typeAnomalie;
    }
}
