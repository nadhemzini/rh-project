package com.exemple.rh.Service;

import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeService {

    @Autowired
    private EmployeRepository employeRepository;

    public List<Employe> getAllEmployes() {
        return employeRepository.findAll();
    }

    public Employe getEmployeById(Long id) {
        return employeRepository.findById(id).orElse(null);
    }

    public Employe saveEmploye(Employe employe) {
        return employeRepository.save(employe);
    }

    public Employe updateEmploye(Long id, Employe employeDetails) {
        Employe employe = employeRepository.findById(id).orElse(null);
        if (employe != null) {
            employe.setFullname(employeDetails.getFullname());
            employe.setZone(employeDetails.getZone());
            employe.setRole(employeDetails.getRole());
            employe.setMatricule(employeDetails.getMatricule());
            return employeRepository.save(employe);
        }
        return null;
    }

    public void deleteEmploye(Long id) {
        employeRepository.deleteById(id);
    }

    public Employe login(String matricule) {
        return employeRepository.findByMatricule(matricule).orElse(null);
    }
    public boolean changerMotDePasse(String matricule, String ancien, String nouveau) {
        Optional<Employe> opt = employeRepository.findByMatricule(matricule);
        if (opt.isPresent()) {
            Employe emp = opt.get();
            if (emp.getPassword().equals(ancien)) {
                emp.setPassword(nouveau);
                employeRepository.save(emp);
                return true;
            }
        }
        return false;
    }

}

