package com.exemple.rh.Controller;

import com.exemple.rh.Entity.DemandeDocument;
import com.exemple.rh.Service.DemandeDocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/demandes-documents")
public class DemandeDocumentController {

    @Autowired
    private DemandeDocumentService service;

    @PostMapping("/ajouter")
    public ResponseEntity<DemandeDocument> ajouter(@RequestBody DemandeDocument demande) {
        return ResponseEntity.ok(service.ajouter(demande));
    }

    @GetMapping("/all")
    public ResponseEntity<List<DemandeDocument>> getAll() {
        return ResponseEntity.ok(service.getAll());
    }

    @PutMapping("/{id}/changer-statut")
    public ResponseEntity<DemandeDocument> changerStatut(
            @PathVariable Long id,
            @RequestParam String statut,
            @RequestParam(required = false) String remarque
    ) {
        return ResponseEntity.ok(service.changerStatut(id, statut, remarque));
    }
    @PutMapping("/{id}/modifier")
    public ResponseEntity<DemandeDocument> modifier(@PathVariable Long id, @RequestBody DemandeDocument demande) {
        return ResponseEntity.ok(service.modifier(id, demande));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> supprimer(@PathVariable Long id) {
        service.supprimer(id);
        return ResponseEntity.noContent().build();
    }

}

