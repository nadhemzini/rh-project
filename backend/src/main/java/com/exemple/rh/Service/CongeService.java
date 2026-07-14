package com.exemple.rh.Service;

import com.exemple.rh.Entity.Conge;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.CongeRepository;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Service
public class CongeService {

    @Autowired
    private CongeRepository congeRepository;

    @Autowired
    private EmployeRepository employeRepository;

    @Autowired
    private EmailService emailService;


    public List<Conge> afficherTousLesConges() {
        return congeRepository.findAll();
    }

    public Conge afficherCongeParId(Long id) {
        return congeRepository.findById(id).orElse(null);
    }

    public Conge ajouterConge(Conge conge) {
        // 1. Statut initial
        conge.setStatut("En attente");
        conge.setValidationResponsableHierarchique("En attente");
        conge.setValidationResponsableRH("En attente");

        // 2. Vérification du matricule et récupération de l'employé
        String matricule = conge.getEmploye() != null ? conge.getEmploye().getMatricule() : null;
        if (matricule == null || matricule.isEmpty()) {
            throw new IllegalArgumentException("Le matricule de l'employé doit être renseigné");
        }
        if (conge.getDateDebut() != null && !conge.getDateDebut().isAfter(LocalDate.now())) {
            throw new RuntimeException("La date de début doit être supérieure à aujourd'hui.");
        }

        Employe employe = employeRepository.findByMatricule(matricule)
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule: " + matricule));
        conge.setEmploye(employe);

        // 3. Sauvegarde du congé
        Conge saved = congeRepository.save(conge);

        // 4. Préparer la liste des emails selon la zone de l'employé
        String zone = employe.getZone() != null ? employe.getZone().trim().toLowerCase() : "";

        List<String> emailsResponsables = new ArrayList<>();
        if (zone.startsWith("administration")) {
            emailsResponsables = List.of(
                    "sabri.chaarana@topnet.tn",
                    "seifeddine.Kmilete@topnet.tn"

            );
        } else {
            switch (zone.toLowerCase()) {
                case "logistique":
                    emailsResponsables = List.of(
                            "Houssemeddine.lakhal@kkt-whe-set.com",
                            "seifeddine.Kmilete@topnet.tn"

                    );
                    break;
                case "qualité":
                    emailsResponsables = List.of(
                            "hiba.mdalla@topnet.tn",
                            "seifeddine.Kmilete@topnet.tn",
                            "helmi.ayedi@kkt-whe-set.com"
                    );
                    break;
                case "prod.cable set":
                    emailsResponsables = List.of(
                            "haythem.said@kkt-whe-set.com",
                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;
                case "maintenance":
                    emailsResponsables = List.of(
                            "Ridha.hedyeoui@topnet.tn",
                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;
                case "prod. poigne":
                    emailsResponsables = List.of(
                            "Bentiba-M@topnet.tn",
                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;
                case "av":
                    emailsResponsables = List.of(
                            "afef.brini@topnet.tn",
                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;
                case "prod. cable wh":
                    emailsResponsables = List.of(
                            "ahmed.nasr@kkt-whe-set.com"
                           
                    );
                    break;
            case "prod. couture":
                    emailsResponsables = List.of(
                            "Bentiba-M@topnet.tn"
                    );
                    break;
                case "RH" :
                    emailsResponsables = List.of(
                            "seifeddine.Kmilete@topnet.tn"

                    );
                    break;
                default:
                    // Optionnel : email par défaut si zone inconnue
                    emailsResponsables = List.of(

                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;

            }
        }
        // 5. Préparation du sujet et contenu du mail
        String sujet = "Nouvelle demande de congé de " + employe.getFullname();
        String contenu = construireContenuEmail(saved);

        // 6. Envoi de l'email
        emailService.envoyerEmail(emailsResponsables, sujet, contenu);

        // 7. Retourner le congé sauvegardé
        return saved;
    }


    private String construireContenuEmail(Conge conge) {
        String nomEmploye = (conge.getEmploye() != null) ? conge.getEmploye().getFullname() : "N/A";
        String matricule = (conge.getEmploye() != null) ? conge.getEmploye().getMatricule() : "N/A";

        return new StringBuilder()
                .append("Bonjour,\n\n")
                .append("Une nouvelle demande de congé a été soumise par ").append(nomEmploye)
                .append(" (Matricule: ").append(matricule).append(").\n\n")
                .append("Détails de la demande :\n")
                .append("- Type : ").append(conge.getType() != null ? conge.getType() : "N/A").append("\n")
                .append("- Date début : ").append(conge.getDateDebut() != null ? conge.getDateDebut() : "N/A").append("\n")
                .append("- Date fin : ").append(conge.getDateFin() != null ? conge.getDateFin() : "N/A").append("\n\n")
                .append("👉 Consulter et valider la demande ici :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nService RH")
                .toString();
    }

    public Conge modifierConge(Long id, Conge congeDetails) {
        Conge conge = congeRepository.findById(id).orElse(null);
        if (conge != null) {
            conge.setDateDebut(congeDetails.getDateDebut());
            conge.setDateFin(congeDetails.getDateFin());
            conge.setType(congeDetails.getType());
            // Do not override statut - it must be recalculated based on validations
            mettreAJourStatutGlobal(conge);
            return congeRepository.save(conge);
        }
        return null;
    }

    public void supprimerConge(Long id) {
        congeRepository.deleteById(id);
    }
    private boolean isValidatorOrHierarchicalRole(String role) {
        if (role == null) return false;
        String r = role.trim().toLowerCase();
        List<String> roles = Arrays.asList(
                "directeur",
                "spécialiste import/export",
                "responsable production",
                "chef service cable",
                "responsable qualité",
                "responsable rh",
                "responsable unité de production",
                "chef service couture",
                "chef service technique",
                "responsable av",
                "validateur supérieur hiérarchique",
                "chef de groupe",
                "agent de qualite",
                "chef d'equipe",
                "gardiendirecteur",
                "agent logistique",
                "assistante de direct",
                "tech sup maintenance",
                "ingenieur methode"
        );
        return roles.contains(r);
    }

    public Conge changerStatutParRole(Long id, String role, String decision, String motifRefus, String matriculeValideur) {
        Conge conge = congeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Congé non trouvé"));

        String roleNettoye = role == null ? "" : role.trim();
        boolean estResponsableRH = roleNettoye.equalsIgnoreCase("Responsable RH");
        boolean estResponsableHierarchique = isValidatorOrHierarchicalRole(roleNettoye);

        Employe targetEmploye = conge.getEmploye();
        if (targetEmploye == null) {
            throw new RuntimeException("Employé cible introuvable pour ce congé.");
        }

        // 1. Récupération du validateur
        Employe valideur = null;
        if (matriculeValideur != null && !matriculeValideur.trim().isEmpty()) {
            valideur = employeRepository.findByMatricule(matriculeValideur.trim())
                    .orElseThrow(() -> new RuntimeException("Validateur introuvable avec le matricule: " + matriculeValideur));
            if (!valideur.isActive()) {
                throw new RuntimeException("Ce compte est désactivé. Vous ne pouvez pas valider les demandes.");
            }
        } else {
            throw new RuntimeException("Le matricule du validateur est requis.");
        }

        String zone = targetEmploye.getZone() != null ? targetEmploye.getZone().trim().toLowerCase() : "";

        // 2. Gestion de l'action selon le rôle du validateur

        // ─── A. VALIDATION PAR LE RESPONSABLE RH ───
        if (estResponsableRH && !valideur.getMatricule().equals("1")) {
            // Un RH ne peut pas valider sa propre demande
            if (targetEmploye.getMatricule().equalsIgnoreCase(valideur.getMatricule())) {
                throw new RuntimeException("Vous ne pouvez pas valider votre propre demande de congé.");
            }
            if (!"Accepté".equals(conge.getValidationResponsableHierarchique())) {
                throw new RuntimeException("Le Responsable Hiérarchique doit valider en premier");
            }
            if (!"En attente".equals(conge.getValidationResponsableRH())) {
                throw new RuntimeException("Déjà validé par RH");
            }
            conge.setValidationResponsableRH(decision);
            if ("Refusé".equalsIgnoreCase(decision)) {
                conge.setMotifRefus(motifRefus != null ? motifRefus : "Aucun motif spécifié");
            }
        }

        // ─── B. VALIDATION PAR LE RESPONSABLE HIÉRARCHIQUE ───
        else if (estResponsableHierarchique || valideur.getMatricule().equals("1")) {
            // Check self-request
            boolean isSelfRequest = targetEmploye.getMatricule().equalsIgnoreCase(valideur.getMatricule());

            if (isSelfRequest) {
                // Seul le matricule 1 peut valider sa propre demande
                if (!valideur.getMatricule().equals("1")) {
                    throw new RuntimeException("Vous ne pouvez pas valider votre propre demande de congé. Elle doit être validée par le matricule 1.");
                }
            } else {
                // Cible n'est pas le validateur lui-même.
                // Est-ce que la cible est un autre validateur ?
                boolean targetIsValidator = isValidatorOrHierarchicalRole(targetEmploye.getRole());
                if (targetIsValidator) {
                    // C'est un autre validateur (ou RH) -> Seul le matricule 1 peut valider
                    if (!valideur.getMatricule().equals("1")) {
                        throw new RuntimeException("Seul le matricule 1 (Mohamed Sabri Chaarana) peut valider la demande d'un validateur.");
                    }
                } else {
                    // C'est un employé normal.
                    // Le validateur doit appartenir à la même zone, sauf si c'est le Directeur pour l'Administration, ou le matricule 1.
                    boolean sameZone = valideur.getZone() != null && targetEmploye.getZone() != null &&
                            valideur.getZone().trim().equalsIgnoreCase(targetEmploye.getZone().trim());
                    boolean isDirecteurAdmin = roleNettoye.equalsIgnoreCase("Directeur") &&
                            (zone.equals("administration") || zone.startsWith("administration/"));

                    if (!sameZone && !isDirecteurAdmin && !valideur.getMatricule().equals("1")) {
                        throw new RuntimeException("Seul le Directeur ou un validateur de la même zone (" + targetEmploye.getZone() + ") peut valider cette demande.");
                    }
                }
            }

            if (!"En attente".equals(conge.getValidationResponsableHierarchique())) {
                throw new RuntimeException("Déjà validé par Responsable Hiérarchique");
            }

            conge.setValidationResponsableHierarchique(decision);
            if ("Refusé".equalsIgnoreCase(decision)) {
                conge.setMotifRefus(motifRefus != null ? motifRefus : "Aucun motif spécifié");
            }

            // Si c'est un auto-congé de RH, pas besoin d'étape RH supplémentaire
            if ("Accepté".equalsIgnoreCase(decision) && targetEmploye.getRole() != null && targetEmploye.getRole().equalsIgnoreCase("Responsable RH")) {
                conge.setValidationResponsableRH("Accepté");
            }

            envoyerEmailRH_ApresValidationHierarchique(conge, decision, roleNettoye);
        }

        // ─── C. RÔLE NON AUTORISÉ ───
        else {
            throw new RuntimeException("Rôle non autorisé à valider");
        }


        mettreAJourStatutGlobal(conge);
        System.out.println("==========");
System.out.println(conge.getValidationResponsableHierarchique());
System.out.println(conge.getValidationResponsableRH());
System.out.println(conge.getStatut());
System.out.println("==========");
        return congeRepository.save(conge);
    }
    private void envoyerEmailRH_ApresValidationHierarchique(Conge conge, String decision, String valideur) {
        String nomEmploye = conge.getEmploye() != null ? conge.getEmploye().getFullname() : "N/A";
        String matricule = conge.getEmploye() != null ? conge.getEmploye().getMatricule() : "N/A";
        String emailRH = "seifeddine.Kmilete@topnet.tn"; // ✅ Adresse RH cible

        String sujet = "Validation par le Responsable Hiérarchique : " + nomEmploye;
        StringBuilder contenu = new StringBuilder();
        contenu.append("Bonjour RH,\n\n")
                .append("Le Responsable Hiérarchique **").append(valideur).append("** a **")
                .append(decision.toUpperCase()).append("** la demande de congé de :\n")
                .append("- Employé : ").append(nomEmploye).append("\n")
                .append("- Matricule : ").append(matricule).append("\n")
                .append("- Type : ").append(conge.getType()).append("\n")
                .append("- Date début : ").append(conge.getDateDebut()).append("\n")
                .append("- Date fin : ").append(conge.getDateFin()).append("\n\n");

        if ("Refusé".equalsIgnoreCase(decision)) {
            contenu.append("❗ Le refus a été effectué sans motif précisé dans le système.\n");
        }

        contenu.append("👉 Connectez-vous pour valider ou refuser cette demande côté RH :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nSystème de Gestion des Congés");

        emailService.envoyerEmail(
                Collections.singletonList(emailRH),
                sujet,
                contenu.toString()
        );
    }



    private boolean isResponsableHierarchique(String role) {
        List<String> roles = Arrays.asList(
                "Directeur",
                "Spécialiste import/export",
                "Responsable Production",
                "Chef Service Cable",
                "Responsable Qualité",
                "Responsable RH", // ✅ inclus ici aussi
                "Responsable Unité de production",
                "Chef Service couture",
                "Chef service technique",
                "Responsable AV"
        );
        return roles.stream().anyMatch(r -> r.equalsIgnoreCase(role.trim()));
    }

    private void mettreAJourStatutGlobal(Conge conge) {
        if (
                "Refusé".equals(conge.getValidationResponsableHierarchique()) ||
                        "Refusé".equals(conge.getValidationResponsableRH())
        ) {
            conge.setStatut("Refusé");
        } else if (
                "Accepté".equals(conge.getValidationResponsableHierarchique()) &&
                        "Accepté".equals(conge.getValidationResponsableRH())
        ) {
            conge.setStatut("Accepté");
        } else {
            conge.setStatut("En attente");
        }
    }

}

