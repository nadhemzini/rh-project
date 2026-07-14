package com.exemple.rh.Controller;

import com.exemple.rh.Entity.AnomaliePaie;
import com.exemple.rh.Service.AnomaliePaieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/anomalies-paie")
@CrossOrigin
public class AnomaliePaieController {

    @Autowired
    private AnomaliePaieService service;

    @GetMapping
    public List<AnomaliePaie> getAll() {
        return service.getAll();
    }

    @PostMapping
    public AnomaliePaie add(@RequestBody AnomaliePaie a) {
        return service.add(a);
    }

    @PutMapping("/{id}")
    public AnomaliePaie update(@PathVariable Long id, @RequestBody AnomaliePaie a) {
        return service.update(id, a);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
    @PatchMapping("/{id}/statut")
    public ResponseEntity<AnomaliePaie> changerStatut(@PathVariable Long id, @RequestBody Map<String, String> statutMap) {
        String statut = statutMap.get("statut");
        AnomaliePaie updated = service.changerStatut(id, statut);
        return ResponseEntity.ok(updated);
    }

}

