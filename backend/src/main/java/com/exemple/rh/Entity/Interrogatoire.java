package com.exemple.rh.Entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class Interrogatoire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDate date;

    @ManyToOne
    private Employe employe;

    private String sujet;

    @Column(columnDefinition = "TEXT")
    private String reponseEmploye;  // Renommé ici pour correspondre au formulaire

    private String punitionProposee; // ex : Avertissement verbal, Suspension...

    private Integer nombreJours; // renommé depuis dureeSuspension

    private LocalDate dateDebutSuspension; // si suspension (à gérer si tu en as besoin)
    private LocalDate dateConseilDiscipline; // si punition de 2nd degré

    // Getters & Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }

    public String getSujet() {
        return sujet;
    }

    public void setSujet(String sujet) {
        this.sujet = sujet;
    }

    public String getReponseEmploye() {
        return reponseEmploye;
    }

    public void setReponseEmploye(String reponseEmploye) {
        this.reponseEmploye = reponseEmploye;
    }

    public String getPunitionProposee() {
        return punitionProposee;
    }

    public void setPunitionProposee(String punitionProposee) {
        this.punitionProposee = punitionProposee;
    }

    public Integer getNombreJours() {
        return nombreJours;
    }

    public void setNombreJours(Integer nombreJours) {
        this.nombreJours = nombreJours;
    }

    public LocalDate getDateDebutSuspension() {
        return dateDebutSuspension;
    }

    public void setDateDebutSuspension(LocalDate dateDebutSuspension) {
        this.dateDebutSuspension = dateDebutSuspension;
    }

    public LocalDate getDateConseilDiscipline() {
        return dateConseilDiscipline;
    }

    public void setDateConseilDiscipline(LocalDate dateConseilDiscipline) {
        this.dateConseilDiscipline = dateConseilDiscipline;
    }
}

