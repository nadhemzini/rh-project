package com.exemple.rh.Controller;

import com.exemple.rh.Entity.AnomaliePointage;
import com.exemple.rh.Service.AnomaliePointageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/anomalies")
public class AnomaliePointageController {

    @Autowired
    private AnomaliePointageService service;



    @PostMapping("/ajouter")
    public ResponseEntity<AnomaliePointage> ajouter(@RequestBody AnomaliePointage anomalie) {
        return ResponseEntity.ok(service.ajouter(anomalie));
    }

    @GetMapping("/all")
    public List<AnomaliePointage> getAll() {
        return service.getAll();
    }

    @PutMapping("/{id}/changer-statut")
    public ResponseEntity<AnomaliePointage> changerStatut(
            @PathVariable Long id,
            @RequestParam String statut

    ) {
        return ResponseEntity.ok(service.changerStatut(id, statut ));
    }

    @PutMapping("/{id}/modifier")
    public ResponseEntity<AnomaliePointage> modifier(@PathVariable Long id, @RequestBody AnomaliePointage anomalie) {
        return ResponseEntity.ok(service.modifier(id, anomalie));
    }

    @DeleteMapping("/{id}")
    public void supprimer(@PathVariable Long id) {
        service.supprimer(id);
    }


}

