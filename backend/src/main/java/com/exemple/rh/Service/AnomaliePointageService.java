package com.exemple.rh.Service;

import com.exemple.rh.Entity.AnomaliePointage;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.AnomaliePointageRepository;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class AnomaliePointageService {

    @Autowired
    private AnomaliePointageRepository repository;
    @Autowired
    private EmployeRepository employeRepository;
    @Autowired
    private EmailService emailService;




    public AnomaliePointage ajouter(AnomaliePointage anomalie) {
        anomalie.setDateDemande(LocalDate.now());
        anomalie.setStatut("En attente");

        Employe employe = employeRepository.findByMatricule(anomalie.getEmploye().getMatricule())
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule : " + anomalie.getEmploye().getMatricule()));
        anomalie.setEmploye(employe);

        AnomaliePointage savedAnomalie = repository.save(anomalie);

        // Liste des destinataires (à adapter selon ton entreprise)
        List<String> destinataires = List.of(

                "seifeddine.Kmilete@topnet.tn"
        );

        try {
            String subject = "Nouvelle Anomalie de Pointage Signalée";
            String message = construireContenuEmail(savedAnomalie);
            emailService.envoyerEmail(destinataires, subject, message);
        } catch (Exception e) {
            System.err.println("Erreur lors de l'envoi de l'e-mail : " + e.getMessage());
        }

        return savedAnomalie;
    }

    private String construireContenuEmail(AnomaliePointage anomalie) {
        String nom = anomalie.getEmploye() != null ? anomalie.getEmploye().getFullname() : "N/A";
        String matricule = anomalie.getEmploye() != null ? anomalie.getEmploye().getMatricule() : "N/A";
        String type = anomalie.getTypeAnomalie() != null ? anomalie.getTypeAnomalie().toString() : "N/A";
        String remarque = anomalie.getRemarque() != null ? anomalie.getRemarque() : "-";
        String date = anomalie.getDateDemande() != null ? anomalie.getDateDemande().toString() : "N/A";
        String statut = anomalie.getStatut();

        return new StringBuilder()
                .append("Bonjour,\n\n")
                .append("Une anomalie de pointage a été signalée par l'employé suivant :\n\n")
                .append("- Nom : ").append(nom).append("\n")
                .append("- Matricule : ").append(matricule).append("\n\n")
                .append("Détails de l'anomalie :\n")
                .append("- Type : ").append(type).append("\n")
                .append("- Remarque : ").append(remarque).append("\n")
                .append("- Date de la demande : ").append(date).append("\n")
                .append("- Statut : ").append(statut).append("\n\n")
                .append("Merci de consulter l'application pour valider ou refuser cette anomalie de Pointage.\n\n")
                .append("👉 Consulter et valider la demande ici :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nService RH")
                .toString();
    }

    public List<AnomaliePointage> getAll() {
        return repository.findAll();
    }

    public AnomaliePointage changerStatut(Long id, String statut) {
        AnomaliePointage a = repository.findById(id).orElseThrow();
        a.setStatut(statut);
        return repository.save(a);
    }

    public void supprimer(Long id) {
        repository.deleteById(id);
    }
    public AnomaliePointage modifier(Long id, AnomaliePointage nouvelleAnomalie) {
        AnomaliePointage existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Anomalie introuvable avec id : " + id));

        existing.setTypeAnomalie(nouvelleAnomalie.getTypeAnomalie());
        existing.setRemarque(nouvelleAnomalie.getRemarque());
        existing.setStatut(nouvelleAnomalie.getStatut());

        // Récupérer l'employé depuis la base par matricule pour être sûr qu'il est "attaché"
        Employe employe = employeRepository.findByMatricule(nouvelleAnomalie.getEmploye().getMatricule())
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule : " + nouvelleAnomalie.getEmploye().getMatricule()));

        existing.setEmploye(employe);

        return repository.save(existing);
    }


}

