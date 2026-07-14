package com.exemple.rh.Entity;

public class ChangerMotDePasseDTO {
    private String matricule;
    private String ancienMotDePasse;
    private String nouveauMotDePasse;

   public String getMatricule() {
       return matricule;
   }
   public void setMatricule(String matricule) {
       this.matricule = matricule;
   }
   public String getAncienMotDePasse() {
       return ancienMotDePasse;
   }
   public void setAncienMotDePasse(String ancienMotDePasse) {
       this.ancienMotDePasse = ancienMotDePasse;
   }
   public String getNouveauMotDePasse() {
       return nouveauMotDePasse;
   }

}

