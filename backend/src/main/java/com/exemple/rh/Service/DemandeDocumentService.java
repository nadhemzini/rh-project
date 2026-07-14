package com.exemple.rh.Service;

import com.exemple.rh.Entity.DemandeDocument;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.DemandeDocumentRepository;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class DemandeDocumentService {

    @Autowired
    private DemandeDocumentRepository repository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private EmployeRepository employeRepository;

    public DemandeDocument ajouter(DemandeDocument demande) {
        demande.setDateDemande(LocalDate.now());
        demande.setStatut("En attente");

        // Vérifier et récupérer l'employé depuis la base
        String matricule = demande.getEmploye() != null ? demande.getEmploye().getMatricule() : null;

        if (matricule == null || matricule.isEmpty()) {
            throw new IllegalArgumentException("Le matricule de l'employé est requis.");
        }

        Employe employe = employeRepository.findByMatricule(matricule)
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule : " + matricule));

        demande.setEmploye(employe);

        // Sauvegarde de la demande
        DemandeDocument saved = repository.save(demande);

        // Envoi d'e-mail après la sauvegarde
        try {
            String subject = "Nouvelle Demande de Document Administratif";
            String message = construireContenuEmail(saved);

            List<String> destinataires = List.of(

                    "seifeddine.Kmilete@topnet.tn"

            );

            emailService.envoyerEmail(destinataires, subject, message);
        } catch (Exception e) {
            System.err.println("Erreur lors de l'envoi de l'e-mail : " + e.getMessage());
        }

        return saved;
    }


    public List<DemandeDocument> getAll() {
        return repository.findAll();
    }

    public List<DemandeDocument> getByEmploye(String matricule) {
        return repository.findByEmployeMatricule(matricule);
    }

    public DemandeDocument changerStatut(Long id, String statut, String remarque) {
        DemandeDocument d = repository.findById(id).orElseThrow();
        d.setStatut(statut);
        d.setRemarque(remarque);
        return repository.save(d);
    }
    private String construireContenuEmail(DemandeDocument demande) {
        String nom = demande.getEmploye() != null ? demande.getEmploye().getFullname() : "Non renseigné";
        String matricule = demande.getEmploye() != null ? demande.getEmploye().getMatricule() : "Non renseigné";
        String typeDoc = demande.getTypeDocument() != null ? demande.getTypeDocument() : "Non précisé";
        String dateDemande = demande.getDateDemande() != null ? demande.getDateDemande().toString() : "Non précisée";

        return new StringBuilder()
                .append("Bonjour,\n\n")
                .append("Une nouvelle demande de document administratif a été soumise par :\n")
                .append("- Nom : ").append(nom).append("\n")
                .append("- Matricule : ").append(matricule).append("\n\n")
                .append("Détails de la demande :\n")
                .append("- Type de document : ").append(typeDoc).append("\n")
                .append("- Date de la demande : ").append(dateDemande).append("\n\n")
                .append("Merci de bien vouloir consulter l'application pour traiter cette demande.\n\n")
                .append("👉 Consulter et valider la demande ici :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nService RH")
                .toString();
    }

    public DemandeDocument modifier(Long id, DemandeDocument updatedDemande) {
        DemandeDocument existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Demande non trouvée avec ID : " + id));

        existing.setTypeDocument(updatedDemande.getTypeDocument());
        existing.setRemarque(updatedDemande.getRemarque());

        // Optionnel : changer l'employé (si besoin)
        if (updatedDemande.getEmploye() != null && updatedDemande.getEmploye().getMatricule() != null) {
            Employe employe = employeRepository.findByMatricule(updatedDemande.getEmploye().getMatricule())
                    .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule : " + updatedDemande.getEmploye().getMatricule()));
            existing.setEmploye(employe);
        }

        return repository.save(existing);
    }
    public void supprimer(Long id) {
        if (!repository.existsById(id)) {
            throw new RuntimeException("Demande introuvable avec l'ID : " + id);
        }
        repository.deleteById(id);
    }

}

