package com.exemple.rh.Controller;

import com.exemple.rh.Entity.AvanceSalaire;
import com.exemple.rh.Service.DemandeAvanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/avances")
public class AvanceSalaireController {
    @Autowired
    private DemandeAvanceService service;

    @PostMapping("/ajouter")
    public ResponseEntity<AvanceSalaire> ajouter(@RequestBody AvanceSalaire demande) {
        return ResponseEntity.ok(service.ajouter(demande));
    }

    @GetMapping("/all")
    public List<AvanceSalaire> getAll() {
        return service.getAll();
    }

    @PutMapping("/{id}/changer-statut")
    public ResponseEntity<AvanceSalaire> changerStatut(@PathVariable Long id, @RequestParam String statut) {
        return ResponseEntity.ok(service.changerStatut(id, statut));
    }
    @PutMapping("/{id}/modifier")
    public ResponseEntity<AvanceSalaire> modifier(@PathVariable Long id, @RequestBody AvanceSalaire demande) {
        return ResponseEntity.ok(service.modifier(id, demande));
    }

    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable Long id) {
        service.supprimer(id);
    }
}

