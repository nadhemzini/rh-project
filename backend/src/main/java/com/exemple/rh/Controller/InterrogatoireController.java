package com.exemple.rh.Controller;

import com.exemple.rh.Entity.Interrogatoire;
import com.exemple.rh.Service.InterrogatoireService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/interrogatoires")
public class InterrogatoireController {

    private final InterrogatoireService service;

    public InterrogatoireController(InterrogatoireService service) {
        this.service = service;
    }

    @GetMapping("/afficher")
    public List<Interrogatoire> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public Interrogatoire getById(@PathVariable Long id) {
        return service.getById(id).orElse(null);
    }

    @PostMapping("/ajouter")
    public Interrogatoire create(@RequestBody Interrogatoire interrogatoire) {
        return service.save(interrogatoire);
    }

    @PutMapping("modifier/{id}")
    public Interrogatoire update(@PathVariable Long id, @RequestBody Interrogatoire updated) {
        updated.setId(id);
        return service.save(updated);
    }

    @DeleteMapping("supprimer/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
