package com.exemple.rh.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

import java.time.LocalDateTime;

@Entity
public class HistoriqueAnomalie {
    @Id
    @GeneratedValue
    private Long id;

    private String statut; // Acceptée, Refusée
    private String commentaire;
    private String validePar;
    private LocalDateTime dateValidation;

    @ManyToOne
    private AnomaliePointage anomalie;

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getStatut() {
        return statut;
    }
    public void setStatut(String statut) {
        this.statut = statut;
    }
    public String getCommentaire() {
        return commentaire;
    }
    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }
    public String getValidePar() {
        return validePar;
    }
    public void setValidePar(String validePar) {
        this.validePar = validePar;
    }
    public LocalDateTime getDateValidation() {
        return dateValidation;
    }
    public void setDateValidation(LocalDateTime dateValidation) {
        this.dateValidation = dateValidation;
    }
    public AnomaliePointage getAnomalie() {
        return anomalie;
    }
    public void setAnomalie(AnomaliePointage anomalie) {
        this.anomalie = anomalie;
    }

}

