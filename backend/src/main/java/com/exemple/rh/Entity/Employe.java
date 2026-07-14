package com.exemple.rh.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.List;

@Entity
public class Employe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String fullname;
    private String password;

    private String zone;

    private String role;

    @Column(unique = true)
    private String matricule;

    private boolean active = true;

    // Relations
    @OneToMany(mappedBy = "employe")
    @JsonIgnore
    private List<Conge> conges;

    @OneToMany(mappedBy = "employe")
    @JsonIgnore
    private List<Autorisation> autorisations;

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }
    public void setFullname(String fullname) {
        this.fullname = fullname;
    }



    public List<Conge> getConges() {
        return conges;
    }
    public void setConges(List<Conge> conges) {
        this.conges = conges;
    }
    public List<Autorisation> getAutorisations() {
        return autorisations;
    }
    public void setAutorisations(List<Autorisation> autorisations) {
        this.autorisations = autorisations;
    }

    public String getZone() {
        return zone;
    }
    public void setZone(String zone) {
        this.zone = zone;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }


    public String getMatricule() {
        return matricule;
    }
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }
    public void setActive(boolean active) {
        this.active = active;
    }
}

