package com.exemple.rh.Entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
public class Autorisation {


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        private LocalDate date;
        private String motif;
        private String type; // "Heure" ou "Journée"
    private String statut = "En attente";
       private String validationResponsableHierarchique = "En attente";
    private String validationResponsableRH = "En attente";
    private String validationChefSecurite = "En attente";

        private LocalTime heureDebut;  // pour type = Heure
        private LocalTime heureFin;// pour type = Heure
        private String direction;
    private String motifRefus;

        @ManyToOne(fetch = FetchType.EAGER)
        private Employe employe;

        // --- Getters et Setters ---

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

        public String getMotif() {
            return motif;
        }
        public void setMotif(String motif) {
            this.motif = motif;
        }

        public String getType() {
            return type;
        }
        public void setType(String type) {
            this.type = type;
        }


    public String getValidationResponsableHierarchique() {
        return validationResponsableHierarchique;
    }
    public void setValidationResponsableHierarchique(String validationResponsableHierarchique) {
        this.validationResponsableHierarchique = validationResponsableHierarchique;
    }
    public String getValidationResponsableRH() {
        return validationResponsableRH;
    }
    public void setValidationResponsableRH(String validationResponsableRH) {
        this.validationResponsableRH = validationResponsableRH;
    }
    public String getValidationChefSecurite() {
        return validationChefSecurite;
    }
    public void setValidationChefSecurite(String validationChefSecurite) {
        this.validationChefSecurite = validationChefSecurite;
    }

        public LocalTime getHeureDebut() {
            return heureDebut;
        }
        public void setHeureDebut(LocalTime heureDebut) {
            this.heureDebut = heureDebut;
        }

        public LocalTime getHeureFin() {
            return heureFin;
        }
        public void setHeureFin(LocalTime heureFin) {
            this.heureFin = heureFin;
        }

        public Employe getEmploye() {
            return employe;
        }
        public void setEmploye(Employe employe) {
            this.employe = employe;
        }
        public String getDirection() {
        return direction;
    }
    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getStatut() {
        return statut;
    }
    public void setStatut(String statut) {
            this.statut = statut;
    }
    public String getMotifRefus() {
        return motifRefus;
    }

    public void setMotifRefus(String motifRefus) {
        this.motifRefus = motifRefus;
    }

}

