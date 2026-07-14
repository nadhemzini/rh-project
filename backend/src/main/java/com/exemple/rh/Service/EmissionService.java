package com.exemple.rh.Service;

import com.exemple.rh.Entity.Emission;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.EmissionRepository;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmissionService {

    @Autowired
    private EmissionRepository emissionRepository;
    @Autowired
    private EmployeRepository employeRepository;
    @Autowired
    private EmailService emailService;

    public Emission ajouterEmission(Emission emission) {
        emission.setStatut("En attente");

        // 🔍 Recherche de l'employé complet
        String matricule = emission.getEmploye() != null ? emission.getEmploye().getMatricule() : null;
        if (matricule == null) throw new RuntimeException("Matricule manquant");

        Employe employe = employeRepository.findByMatricule(matricule)
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule: " + matricule));
        emission.setEmploye(employe);

        Emission saved = emissionRepository.save(emission);

        // 📩 Envoi mail au RH
        String sujet = "Nouvelle mission ajoutée par " + employe.getFullname();
        String contenu = construireContenuEmail(employe, emission);
        List<String> destinataires = List.of("seifeddine.Kmilete@topnet.tn");

        emailService.envoyerEmail(destinataires, sujet, contenu);

        return saved;
    }
    private String construireContenuEmail(Employe employe, Emission emission) {
        return new StringBuilder()
                .append("Bonjour RH,\n\n")
                .append("Une nouvelle mission a été soumise par :\n")
                .append("- Employé : ").append(employe.getFullname()).append("\n")
                .append("- Matricule : ").append(employe.getMatricule()).append("\n")
                .append("- Zone : ").append(employe.getZone()).append("\n")
                .append("- Type : ").append(emission.getType()).append("\n")
                .append("- Date début : ").append(emission.getDateDebut()).append("\n")
                .append("- Date fin : ").append(emission.getDateFin()).append("\n\n")
                .append("👉 Connectez-vous pour suivre ou modifier cette mission :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nSystème de Gestion des Missions")
                .toString();
    }


    public List<Emission> getAllEmissions() {
        return emissionRepository.findAll();
    }

    public Optional<Emission> getEmissionById(Long id) {
        return emissionRepository.findById(id);
    }

    public Emission modifierEmission(Long id, Emission nouvelleEmission) {
        return emissionRepository.findById(id).map(e -> {
            e.setDateDebut(nouvelleEmission.getDateDebut());
            e.setDateFin(nouvelleEmission.getDateFin());
            e.setType(nouvelleEmission.getType());
            e.setStatut(nouvelleEmission.getStatut());
            e.setEmploye(nouvelleEmission.getEmploye());
            return emissionRepository.save(e);
        }).orElse(null);
    }

    public void supprimerEmission(Long id) {
        emissionRepository.deleteById(id);
    }
    public Emission changerStatut(Long id, String statut) {
        Emission emission = emissionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Émission non trouvée avec l'id : " + id));
        emission.setStatut(statut);
        return emissionRepository.save(emission);
    }

}

