package com.exemple.rh.Entity;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
public class DemandeDocument {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String typeDocument; // ex: "Attestation de travail"
    private String statut = "En attente"; // ou "Acceptée", "Rejetée"

    private LocalDate dateDemande;

    @ManyToOne
    private Employe employe;

    private String remarque; // facultatif : commentaires RH ou autre

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getTypeDocument() {
        return typeDocument;
    }
    public void setTypeDocument(String typeDocument) {
        this.typeDocument = typeDocument;
    }
    public String getStatut() {
        return statut;
    }
    public void setStatut(String statut) {
        this.statut = statut;
    }
    public LocalDate getDateDemande() {
        return dateDemande;
    }
    public void setDateDemande(LocalDate dateDemande) {
        this.dateDemande = dateDemande;
    }
    public Employe getEmploye() {
        return employe;
    }
    public void setEmploye(Employe employe) {
        this.employe = employe;
    }
    public String getRemarque() {
        return remarque;
    }
    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

}

