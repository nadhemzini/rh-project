package com.exemple.rh.Service;

import com.exemple.rh.Entity.AvanceSalaire;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.DemandeAvanceRepository;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class DemandeAvanceService {

    @Autowired
    private DemandeAvanceRepository repository;

    @Autowired
    private EmailService emailService;


    @Autowired
    private EmployeRepository employeRepository;

    public AvanceSalaire ajouter(AvanceSalaire demande) {
        demande.setDateDemande(LocalDate.now());
        demande.setStatut("En attente");

        // Vérification et récupération de l'employé
        Employe employe = employeRepository.findByMatricule(demande.getEmploye().getMatricule())
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule : " + demande.getEmploye().getMatricule()));
        demande.setEmploye(employe);

        // Sauvegarde de la demande
        AvanceSalaire savedDemande = repository.save(demande);

        // Liste des destinataires (à personnaliser selon ton besoin)
        List<String> destinataires = List.of(

                "seifeddine.Kmilete@topnet.tn"
        );

        try {
            String subject = "Nouvelle demande d'avance sur salaire";
            String message = construireContenuEmail(savedDemande);
            emailService.envoyerEmail(destinataires, subject, message);
        } catch (Exception e) {
            System.err.println("Erreur lors de l'envoi de l'e-mail : " + e.getMessage());
        }

        return savedDemande;
    }
    private String construireContenuEmail(AvanceSalaire demande) {
        String nom = (demande.getEmploye() != null) ? demande.getEmploye().getFullname() : "N/A";
        String matricule = (demande.getEmploye() != null) ? demande.getEmploye().getMatricule() : "N/A";
        String montant = demande.getMontant() != null ? demande.getMontant().toString() : "N/A";
        String remarque = demande.getRemarque() != null ? demande.getRemarque() : "-";
        String date = demande.getDateDemande() != null ? demande.getDateDemande().toString() : "N/A";

        return new StringBuilder()
                .append("Bonjour,\n\n")
                .append("Une nouvelle demande d'avance sur salaire a été soumise.\n\n")
                .append("Informations sur le demandeur :\n")
                .append("- Nom : ").append(nom).append("\n")
                .append("- Matricule : ").append(matricule).append("\n\n")
                .append("Détails de la demande :\n")
                .append("- Montant demandé : ").append(montant).append(" TND\n")
                .append("- Remarque : ").append(remarque).append("\n")
                .append("- Date de la demande : ").append(date).append("\n\n")
                .append("Statut actuel : ").append(demande.getStatut()).append("\n\n")
                .append("Merci de consulter l'application pour prendre une décision.\n\n")
                .append("👉 Consulter et valider la demande ici :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nService RH")
                .toString();
    }


    public List<AvanceSalaire> getAll() {
        return repository.findAll();
    }

    public List<AvanceSalaire> getByEmploye(String matricule) {
        return repository.findByEmployeMatricule(matricule);
    }

    public AvanceSalaire changerStatut(Long id, String statut) {
        AvanceSalaire demande = repository.findById(id).orElseThrow();
        demande.setStatut(statut);
        return repository.save(demande);
    }
    public AvanceSalaire modifier(Long id, AvanceSalaire nouvelleDemande) {
        AvanceSalaire existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Demande introuvable avec l'id : " + id));

        // Met à jour les champs modifiables (exemple, adapte selon ton besoin)
        existing.setMontant(nouvelleDemande.getMontant());
        existing.setRemarque(nouvelleDemande.getRemarque());
        existing.setStatut(nouvelleDemande.getStatut());
        existing.setEmploye(nouvelleDemande.getEmploye());


        return repository.save(existing);
    }

    public void supprimer(Long id) {
        repository.deleteById(id);
    }
}

