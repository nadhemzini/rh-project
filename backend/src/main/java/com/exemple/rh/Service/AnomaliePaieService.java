package com.exemple.rh.Service;

import com.exemple.rh.Entity.AnomaliePaie;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.AnomaliePaieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnomaliePaieService {
    @Autowired
    private AnomaliePaieRepository repo;
    @Autowired
    private EmailService emailService;

    public List<AnomaliePaie> getAll() {
        return repo.findAll();
    }

    public AnomaliePaie add(AnomaliePaie a) {
        AnomaliePaie saved = repo.save(a);

        List<String> destinataires = List.of(

                "seifeddine.Kmilete@topnet.tn"

        );

        String sujet = "Nouvelle anomalie paie créée";
        String contenu = construireContenuEmail(saved);

        emailService.envoyerEmail(destinataires, sujet, contenu);

        return saved;
    }
    private String construireContenuEmail(AnomaliePaie anomalie) {
        Employe e = anomalie.getEmploye();
        String nomEmploye = (anomalie.getEmploye() != null) ? anomalie.getEmploye().getFullname() : "N/A";
        return new StringBuilder()
                .append("Bonjour,\n\n")
                .append("Une nouvelle anomalie de paie a été enregistrée pour l'employé ").append(nomEmploye)
                .append(" (Matricule : ").append(e != null ? e.getMatricule() : "N/A").append(").\n\n")
                .append("Détails :\n")
                .append("- Type : ").append(anomalie.getTypeAnomalie()).append("\n")
                .append("- Description : ").append(anomalie.getDescription()).append("\n")
                .append("- Date : ").append(anomalie.getDateAnomalie()).append("\n")
                .append("- Statut : ").append(anomalie.getStatut()).append("\n\n")
                .append("Merci de consulter l'application pour plus de détails.\n\n")
                .append("👉 Consulter et valider la demande ici :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nService RH")
                .toString();
    }


    public void delete(Long id) {
        repo.deleteById(id);
    }

    public AnomaliePaie update(Long id, AnomaliePaie updated) {
        updated.setId(id);
        return repo.save(updated);
    }
    public AnomaliePaie changerStatut(Long id, String statut) {
        AnomaliePaie a = repo.findById(id)
                .orElseThrow(() -> new RuntimeException("Anomalie non trouvée : " + id));
        a.setStatut(statut);
        return repo.save(a);
    }

}

