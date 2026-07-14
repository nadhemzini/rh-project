package com.exemple.rh.Controller;

import com.exemple.rh.Entity.ChangementMotDePasseDTO;
import com.exemple.rh.Entity.ChangerMotDePasseDTO;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Entity.LoginRequestDTO;
import com.exemple.rh.Repository.EmployeRepository;
import com.exemple.rh.Service.AutorisationService;
import com.exemple.rh.Service.EmployeService;
import com.exemple.rh.Service.JwtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/employes")
public class EmployeController {

    @Autowired
    private EmployeService employeService;

    @Autowired
    private JwtService jwtService;
    @Autowired
    private EmployeRepository employeRepository;

    @GetMapping("/afficher")
    public List<Employe> getAllEmployes() {
        return employeService.getAllEmployes();
    }

    @GetMapping("afficher/{id}")
    public Employe getEmployeById(@PathVariable Long id) {
        return employeService.getEmployeById(id);
    }

    @PostMapping("/ajouter")
    public Employe createEmploye(@RequestBody Employe employe) {
        return employeService.saveEmploye(employe);
    }

    @PutMapping("modifier/{id}")
    public Employe updateEmploye(@PathVariable Long id, @RequestBody Employe employeDetails) {
        return employeService.updateEmploye(id, employeDetails);
    }

    @DeleteMapping("supprimer/{id}")
    public void deleteEmploye(@PathVariable Long id) {
        employeService.deleteEmploye(id);
    }
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequestDTO loginRequest) {
        Employe user = employeService.login(loginRequest.getMatricule());

        if (user == null) {
            return ResponseEntity.status(401).body("Matricule incorrect !");
        }

        // Vérifier mot de passe
        if (!user.getPassword().equals(loginRequest.getPassword())) {
            return ResponseEntity.status(401).body("Mot de passe incorrect !");
        }

        // Vérifier si le compte est actif
        if (!user.isActive()) {
            return ResponseEntity.status(403).body("Ce compte est désactivé. Contactez le RH.");
        }

        // Vérifier le rôle
        List<String> rolesAutorises = Arrays.asList("Responsable RH","Sécurité","Validateur Supérieur Hiérarchique","Chef de Groupe","Agent de qualite", "Chef d'equipe", "GARDIEN","Directeur ","Spécialiste import/export","Responsable Production","Chef Service Cable","Responsable Qualité","Responsable Unité de production","Chef Service couture","Agent Logistique","Chef service technique","ASSISTANTE DE DIRECT","Responsable AV","TECH sup maintenance","Ingenieur Methode");
        if (!rolesAutorises.contains(user.getRole())) {
            return ResponseEntity.status(403).body("Accès refusé pour ce rôle !");
        }

        // Générer et retourner token
        String token = jwtService.generateToken(user);

        Map<String, Object> response = new HashMap<>();
        response.put("id", user.getId());
        response.put("nom", user.getFullname());
        response.put("fullname", user.getFullname());
        response.put("role", user.getRole());
        response.put("token", token);
        response.put("zone", user.getZone());
        response.put("matricule", user.getMatricule());

        return ResponseEntity.ok(response);

    }



    @GetMapping("/verifier-identifiant")
    public ResponseEntity<?> verifierIdentifiant(@RequestParam String identifiant) {
        boolean existe = employeRepository.existsByMatricule(identifiant);
        return ResponseEntity.ok(existe);
    }

    @GetMapping("/matricule/{matricule}")
    public ResponseEntity<Employe> getEmployeByMatricule(@PathVariable String matricule) {
        Optional<Employe> employe = employeRepository.findByMatricule(matricule);
        return employe.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    @PostMapping("/changer-mot-de-passe")
    public ResponseEntity<?> changerMotDePasse(@RequestBody Map<String, String> body) {
        String identifiant = body.get("identifiant");
        String nouveauMotDePasse = body.get("nouveauMotDePasse");

        Employe employe = employeRepository.findByMatricule(identifiant).orElse(null);
        if (employe == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Employé non trouvé");
        }

        employe.setPassword(nouveauMotDePasse);
        employeRepository.save(employe);

        return ResponseEntity.ok(Map.of("message", "Mot de passe mis à jour avec succès"));
    }





}

