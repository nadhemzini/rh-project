package com.exemple.rh.Controller;

import com.exemple.rh.Entity.Infermerie;
import com.exemple.rh.Service.InfermerieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/infermerie")
public class InfermerieController {

    @Autowired
    private InfermerieService infermerieService;

    @PostMapping("/ajouter")
    public Infermerie ajouter(@RequestBody Infermerie infermerie) {
        return infermerieService.ajouterInfermerie(infermerie);
    }

    @GetMapping("/afficher")
    public List<Infermerie> afficher() {
        return infermerieService.getAllInfermeries();
    }

    @GetMapping("/{id}")
    public Infermerie getById(@PathVariable Long id) {
        return infermerieService.getInfermerieById(id).orElse(null);
    }

    @PutMapping("/modifier/{id}")
    public Infermerie modifier(@PathVariable Long id, @RequestBody Infermerie infermerie) {
        return infermerieService.modifierInfermerie(id, infermerie);
    }

    @DeleteMapping("/supprimer/{id}")
    public void supprimer(@PathVariable Long id) {
        infermerieService.supprimerInfermerie(id);
    }

    @PatchMapping("/{id}/statut")
    public ResponseEntity<Infermerie> changerStatut(@PathVariable Long id, @RequestBody Map<String, String> statutMap) {
        String statut = statutMap.get("statut");
        Infermerie updated = infermerieService.changerStatut(id, statut);
        return ResponseEntity.ok(updated);
    }
}

