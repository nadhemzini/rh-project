package com.exemple.rh.Service;

import com.exemple.rh.Entity.ChangeValidateurDTO;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ValidateurService {

    @Autowired
    private EmployeRepository employeRepository;

    private static final String VALIDATOR_ROLE = "Validateur Supérieur Hiérarchique";
    private static final String SECURITY_ROLE = "Sécurité";
    private static final List<String> MANAGEMENT_ROLES = Arrays.asList(VALIDATOR_ROLE, SECURITY_ROLE);

    public List<Map<String, Object>> getAllValidators() {
        List<Employe> allEmployees = employeRepository.findAll();
        
        Map<String, List<Employe>> validatorsByZone = allEmployees.stream()
                .filter(emp -> MANAGEMENT_ROLES.stream().anyMatch(role -> role.equalsIgnoreCase(emp.getRole())))
                .collect(Collectors.groupingBy(emp -> emp.getZone() != null ? emp.getZone() : "Non défini"));
        
        List<Map<String, Object>> result = new ArrayList<>();
        
        for (Map.Entry<String, List<Employe>> entry : validatorsByZone.entrySet()) {
            String zone = entry.getKey();
            List<Employe> validators = entry.getValue();
            
            long employeeCount = allEmployees.stream()
                    .filter(emp -> zone.equals(emp.getZone()))
                    .count();
            
            for (Employe validator : validators) {
                Map<String, Object> validatorInfo = new HashMap<>();
                validatorInfo.put("id", validator.getId());
                validatorInfo.put("fullname", validator.getFullname());
                validatorInfo.put("matricule", validator.getMatricule());
                validatorInfo.put("role", validator.getRole());
                validatorInfo.put("zone", zone);
                validatorInfo.put("active", validator.isActive());
                validatorInfo.put("employeeCount", employeeCount);
                result.add(validatorInfo);
            }
        }
        
        return result;
    }

    public List<Employe> getEmployeesByZone(String zone) {
        return employeRepository.findByZone(zone).stream()
                .filter(emp -> !MANAGEMENT_ROLES.stream().anyMatch(role -> role.equalsIgnoreCase(emp.getRole())))
                .collect(Collectors.toList());
    }

    @Transactional
    public Map<String, Object> changeValidator(ChangeValidateurDTO dto) {
        Employe oldValidator = employeRepository.findById(dto.getOldValidatorId())
                .orElseThrow(() -> new RuntimeException("Ancien validateur non trouvé"));
        
        Employe newValidator = employeRepository.findById(dto.getNewValidatorId())
                .orElseThrow(() -> new RuntimeException("Nouveau validateur non trouvé"));
        
        if (!Objects.equals(oldValidator.getZone(), newValidator.getZone())) {
            throw new RuntimeException("Le remplaçant doit appartenir à la même zone.");
        }
        
        boolean oldIsManagement = MANAGEMENT_ROLES.stream().anyMatch(role -> role.equalsIgnoreCase(oldValidator.getRole()));
        if (!oldIsManagement) {
            throw new RuntimeException("L'ancien employé n'a pas un rôle de validateur ou sécurité");
        }
        
        boolean newIsManagement = MANAGEMENT_ROLES.stream().anyMatch(role -> role.equalsIgnoreCase(newValidator.getRole()));
        if (newIsManagement) {
            throw new RuntimeException("Le nouvel employé est déjà un validateur ou sécurité.");
        }

        String targetRole = oldValidator.getRole();
        
        oldValidator.setRole("Employé");
        employeRepository.save(oldValidator);
        
        newValidator.setRole(targetRole);
        if (newValidator.getMatricule() == null || newValidator.getMatricule().trim().isEmpty()) {
            String generatedMatricule = "EMP" + newValidator.getId();
            newValidator.setMatricule(generatedMatricule);
            newValidator.setPassword(generatedMatricule);
        } else {
            newValidator.setPassword(newValidator.getMatricule());
        }
        newValidator.setActive(true);
        employeRepository.save(newValidator);
        
        Map<String, Object> result = new HashMap<>();
        result.put("message", "Validator changed successfully");
        result.put("oldValidator", oldValidator.getFullname());
        result.put("newValidator", newValidator.getFullname());
        result.put("zone", oldValidator.getZone());
        result.put("role", targetRole);
        
        return result;


    }

    @Transactional
    public Employe toggleValidatorStatus(Long id, boolean active) {
        Employe employe = employeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Employé non trouvé"));
        
        employe.setActive(active);
        return employeRepository.save(employe);
    }
}
