package com.exemple.rh.Controller;

import com.exemple.rh.Entity.Emission;
import com.exemple.rh.Service.EmissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/emissions")

public class EmissionController {

    @Autowired
    private EmissionService emissionService;

    @PostMapping("/ajouter")
    public Emission ajouter(@RequestBody Emission emission) {
        return emissionService.ajouterEmission(emission);
    }

    @GetMapping("/afficher")
    public List<Emission> afficher() {
        return emissionService.getAllEmissions();
    }

    @GetMapping("/{id}")
    public Emission getById(@PathVariable Long id) {
        return emissionService.getEmissionById(id).orElse(null);
    }

    @PutMapping("/modifier/{id}")
    public Emission modifier(@PathVariable Long id, @RequestBody Emission emission) {
        return emissionService.modifierEmission(id, emission);
    }

    @DeleteMapping("/supprimer/{id}")
    public void supprimer(@PathVariable Long id) {
        emissionService.supprimerEmission(id);
    }
    @PatchMapping("/{id}/statut")
    public ResponseEntity<Emission> changerStatut(@PathVariable Long id, @RequestBody Map<String, String> statutMap) {
        String statut = statutMap.get("statut");
        Emission updated = emissionService.changerStatut(id, statut);
        return ResponseEntity.ok(updated);
    }

}

