package com.exemple.rh.Service;
import com.exemple.rh.Entity.Interrogatoire;
import com.exemple.rh.Repository.InterrogatoireRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InterrogatoireService {

    private final InterrogatoireRepository repository;

    public InterrogatoireService(InterrogatoireRepository repository) {
        this.repository = repository;
    }

    public List<Interrogatoire> getAll() {
        return repository.findAll();
    }

    public Optional<Interrogatoire> getById(Long id) {
        return repository.findById(id);
    }

    public Interrogatoire save(Interrogatoire interrogatoire) {
        return repository.save(interrogatoire);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
