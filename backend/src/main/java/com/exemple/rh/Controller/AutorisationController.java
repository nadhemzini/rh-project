package com.exemple.rh.Controller;

import com.exemple.rh.Entity.Autorisation;
import com.exemple.rh.Repository.EmployeRepository;
import com.exemple.rh.Service.AutorisationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/autorisations")
public class AutorisationController {

    @Autowired
    private AutorisationService autorisationService;

    @Autowired
    private EmployeRepository employeRepository;

    // GET : Afficher toutes les autorisations
    @GetMapping("/afficher")
    public List<Autorisation> afficherToutesLesAutorisations() {
        return autorisationService.afficherToutesLesAutorisations();
    }

    // GET : Afficher une autorisation par ID
    @GetMapping("/afficher/{id}")
    public Autorisation afficherAutorisationParId(@PathVariable Long id) {
        return autorisationService.afficherAutorisationParId(id);
    }


    @PostMapping("/ajouter")
    public Autorisation ajouterAutorisation(@RequestBody Autorisation autorisation) {
        return autorisationService.ajouterAutorisation(autorisation);
    }


    @PutMapping("/modifier/{id}")
    public Autorisation modifierAutorisation(@PathVariable Long id, @RequestBody Autorisation details) {
        return autorisationService.modifierAutorisation(id, details);
    }


    @DeleteMapping("/supprimer/{id}")
    public void supprimerAutorisation(@PathVariable Long id) {
        autorisationService.supprimerAutorisation(id);
    }
    @PutMapping("/changer-statut/{id}")
    public ResponseEntity<?> changerStatutParRole(@PathVariable Long id,
                                                  @RequestParam String role,
                                                  @RequestParam String statut,
                                                  @RequestParam(required = false) String motifRefus,
                                                  @RequestParam(required = false) String matricule) {
        try {
            // Check if validator is active (if matricule is provided)
            if (matricule != null && !matricule.isEmpty()) {
                var employe = employeRepository.findByMatricule(matricule);
                if (employe.isPresent() && !employe.get().isActive()) {
                    return ResponseEntity.status(403).body("Ce compte est désactivé. Vous ne pouvez pas valider les demandes.");
                }
            }
            
            Autorisation aut = autorisationService.changerStatutParRole(id, role, statut, motifRefus, matricule);
            return ResponseEntity.ok(aut);
        } catch (RuntimeException ex) {
            return ResponseEntity.badRequest().body(ex.getMessage());
        }
    }


    @GetMapping("/top")
    public List<Autorisation> getTopAutorisations() {
        return autorisationService.getTopAutorisations();
    }




}

