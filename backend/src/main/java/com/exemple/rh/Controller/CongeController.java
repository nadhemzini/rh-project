package com.exemple.rh.Controller;

import com.exemple.rh.Entity.Conge;
import com.exemple.rh.Service.CongeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/conges")
public class CongeController {

    @Autowired
    private CongeService congeService;

    // GET : Afficher tous les congés
    @GetMapping("/afficher")
    public List<Conge> afficherTousLesConges() {
        return congeService.afficherTousLesConges();
    }

    // GET : Afficher un congé par ID
    @GetMapping("/afficher/{id}")
    public Conge afficherCongeParId(@PathVariable Long id) {
        return congeService.afficherCongeParId(id);
    }

    // POST : Ajouter un congé
    @PostMapping("/ajouter")
    public Conge ajouterConge(@RequestBody Conge conge) {
        return congeService.ajouterConge(conge);
    }

    // PUT : Modifier un congé
    @PutMapping("/modifier/{id}")
    public Conge modifierConge(@PathVariable Long id, @RequestBody Conge congeDetails) {
        return congeService.modifierConge(id, congeDetails);
    }

    // DELETE : Supprimer un congé
    @DeleteMapping("/supprimer/{id}")
    public void supprimerConge(@PathVariable Long id) {
        congeService.supprimerConge(id);
    }

    @PutMapping("/changer-statut/{id}")
    public ResponseEntity<?> changerStatutParRole(@PathVariable Long id,
                                                  @RequestParam String role,
                                                  @RequestParam String statut,
                                                  @RequestParam(required = false) String motifRefus,
                                                  @RequestParam(required = false) String matricule) {
        try {
            Conge conge = congeService.changerStatutParRole(id, role, statut, motifRefus, matricule);
            return ResponseEntity.ok(conge);
        } catch (RuntimeException ex) {
            return ResponseEntity.badRequest().body(ex.getMessage());
        }
    }



}

