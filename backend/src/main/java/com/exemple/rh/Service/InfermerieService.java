package com.exemple.rh.Service;

import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Entity.Infermerie;
import com.exemple.rh.Repository.EmployeRepository;
import com.exemple.rh.Repository.InfermerieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InfermerieService {

    @Autowired
    private InfermerieRepository infermerieRepository;

    @Autowired
    private EmployeRepository employeRepository;

    @Autowired
    private EmailService emailService;

    public Infermerie ajouterInfermerie(Infermerie infermerie) {
        infermerie.setStatut("En attente");

        String matricule = infermerie.getEmploye() != null ? infermerie.getEmploye().getMatricule() : null;
        if (matricule == null) throw new RuntimeException("Matricule manquant");

        Employe employe = employeRepository.findByMatricule(matricule)
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule: " + matricule));
        infermerie.setEmploye(employe);

        Infermerie saved = infermerieRepository.save(infermerie);

        // 📩 Envoi mail au RH
        String sujet = "Nouvelle visite à l'infirmerie ajoutée par " + employe.getFullname();
        String contenu = construireContenuEmail(employe, infermerie);
        List<String> destinataires = List.of("seifeddine.Kmilete@topnet.tn"); // à adapter

        emailService.envoyerEmail(destinataires, sujet, contenu);

        return saved;
    }

    private String construireContenuEmail(Employe employe, Infermerie infermerie) {
        return new StringBuilder()
                .append("Bonjour RH,\n\n")
                .append("Une nouvelle visite à l'infirmerie a été soumise par :\n")
                .append("- Employé : ").append(employe.getFullname()).append("\n")
                .append("- Matricule : ").append(employe.getMatricule()).append("\n")
                .append("- Zone : ").append(employe.getZone()).append("\n")
                .append("- Type : ").append(infermerie.getType()).append("\n")
                .append("- Motif : ").append(infermerie.getMotif()).append("\n")
                .append("- Date : ").append(infermerie.getDate()).append("\n\n")
                .append("👉 Connectez-vous pour gérer cette visite :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nSystème de Gestion des Visites Médicales")
                .toString();
    }

    public List<Infermerie> getAllInfermeries() {
        return infermerieRepository.findAll();
    }

    public Optional<Infermerie> getInfermerieById(Long id) {
        return infermerieRepository.findById(id);
    }

    public Infermerie modifierInfermerie(Long id, Infermerie nouvelleInfermerie) {
        return infermerieRepository.findById(id).map(i -> {
            i.setDate(nouvelleInfermerie.getDate());
            i.setType(nouvelleInfermerie.getType());
            i.setMotif(nouvelleInfermerie.getMotif());
            i.setStatut(nouvelleInfermerie.getStatut());
            i.setEmploye(nouvelleInfermerie.getEmploye());
            return infermerieRepository.save(i);
        }).orElse(null);
    }

    public void supprimerInfermerie(Long id) {
        infermerieRepository.deleteById(id);
    }

    public Infermerie changerStatut(Long id, String statut) {
        Infermerie infermerie = infermerieRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Visite non trouvée avec l'id : " + id));
        infermerie.setStatut(statut);
        return infermerieRepository.save(infermerie);
    }
}

