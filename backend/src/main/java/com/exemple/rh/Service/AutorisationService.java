package com.exemple.rh.Service;

import com.exemple.rh.Entity.Autorisation;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.AutorisationRepository;
import com.exemple.rh.Repository.EmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class AutorisationService {

    @Autowired
    private AutorisationRepository autorisationRepository;
    @Autowired
    private EmployeRepository employeRepository;

    @Autowired
    private EmailService emailService;

    public List<Autorisation> afficherToutesLesAutorisations() {
        return autorisationRepository.findAll();
    }

    public Autorisation afficherAutorisationParId(Long id) {
        return autorisationRepository.findById(id).orElse(null);
    }

    public Autorisation ajouterAutorisation(Autorisation autorisation) {
        autorisation.setValidationResponsableHierarchique("En attente");
        autorisation.setValidationResponsableRH("En attente");
        autorisation.setValidationChefSecurite("En attente");
        autorisation.setStatut("En attente");
        // Récupération du matricule
        String matricule = (autorisation.getEmploye() != null) ? autorisation.getEmploye().getMatricule() : null;
        if (matricule == null || matricule.isEmpty()) {
            throw new IllegalArgumentException("Le matricule de l'employé doit être renseigné");
        }

        // Recherche de l’employé
        Employe employe = employeRepository.findByMatricule(matricule)
                .orElseThrow(() -> new RuntimeException("Employé introuvable avec le matricule: " + matricule));

        autorisation.setEmploye(employe);

        // Sauvegarde en base
        Autorisation savedAutorisation = autorisationRepository.save(autorisation);

        String zone = employe.getZone() != null ? employe.getZone().trim().toLowerCase() : "";

        List<String> emailsResponsables = new ArrayList<>();
        if (zone.startsWith("administration")&&zone.startsWith("Direction")) {
            emailsResponsables = List.of(
                    "sabri.chaarana@kkt-whe-set.com",
                    "seifeddine.Kmilete@topnet.tn",
                    "anwar.benaicha@kkt-whe-set.com"
            );
        } else {
            switch (zone.toLowerCase()) {
                case "logistique":
                    emailsResponsables = List.of(
                            "Houssemeddine.lakhal@kkt-whe-set.com",
                            "seifeddine.Kmilete@topnet.tn",
                            "mayssa.benali@kkt-whe-set.com"
                    );
                    break;
                case "qualité":
                    emailsResponsables = List.of(
                            "hiba.mdalla@kkt-whe-set.com",
                            "seifeddine.Kmilete@topnet.tn",
                            "helmi.ayedi@kkt-whe-set.com"
                    );
                case "Qualité":
                    emailsResponsables = List.of(
                            "hiba.mdalla@kkt-whe-set.com",
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
                case "Méthode":
                    emailsResponsables = List.of(
                            "afef.brini@kkt-whe-set.com",
                            "seifeddine.Kmilete@topnet.tn",
                            "Kaisser.bouassida@kkt-whe-set.com"
                    );
                    break;
                case "prod. poigne":
                    emailsResponsables = List.of(
                            "Bentiba-M@topnet.tn",
                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;
                case "Norsystec":
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
                            "ahmed.nasr@kkt-whe-set.com",
                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;
                case "Prod. Cable WH-E":
                    emailsResponsables = List.of(
                            "ahmed.nasr@kkt-whe-set.com",
                            "seifeddine.Kmilete@topnet.tn"
                    );
                    break;
                case "prod. couture":
                    emailsResponsables = List.of(
                            "Bentiba-M@topnet.tn"
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
        String sujet = "Nouvelle demande d'autorisation de " + employe.getFullname();
        String contenu = construireContenuEmail(savedAutorisation);

        // 6. Envoi de l'email
        emailService.envoyerEmail(emailsResponsables, sujet, contenu);


        return savedAutorisation;
    }

    private String construireContenuEmail(Autorisation autorisation) {
        String nomEmploye = (autorisation.getEmploye() != null) ? autorisation.getEmploye().getFullname() : "N/A";
        String matricule = (autorisation.getEmploye() != null) ? autorisation.getEmploye().getMatricule() : "N/A";
        String type = (autorisation.getType() != null) ? autorisation.getType() : "N/A";
        String date = (autorisation.getDate() != null) ? autorisation.getDate().toString() : "N/A";
        String motif = (autorisation.getMotif() != null) ? autorisation.getMotif() : "N/A";
        String direction = (autorisation.getDirection() != null) ? autorisation.getDirection() : "N/A";

        StringBuilder sb = new StringBuilder();
        sb.append("Bonjour,\n\n")
                .append("Une nouvelle demande d'autorisation a été soumise par ").append(nomEmploye)
                .append(" (Matricule: ").append(matricule).append(").\n\n")
                .append("Détails de la demande :\n")
                .append("- Type : ").append(type).append("\n")
                .append("- Date : ").append(date).append("\n")
                .append("- Direction : ").append(direction).append("\n");

        // Affichage conditionnel des heures
        if ("Entrée".equalsIgnoreCase(direction)) {
            sb.append("- Heure d'entrée : ")
                    .append(autorisation.getHeureDebut() != null ? autorisation.getHeureDebut() : "N/A")
                    .append("\n");
        } else if ("Sortie".equalsIgnoreCase(direction)) {
            sb.append("- Heure de sortie : ")
                    .append(autorisation.getHeureFin() != null ? autorisation.getHeureFin() : "N/A")
                    .append("\n");
        } else {
            sb.append("- Heure début : ")
                    .append(autorisation.getHeureDebut() != null ? autorisation.getHeureDebut() : "N/A")
                    .append("\n")
                    .append("- Heure fin : ")
                    .append(autorisation.getHeureFin() != null ? autorisation.getHeureFin() : "N/A")
                    .append("\n");
        }


        sb.append("- Motif : ").append(motif).append("\n\n")
                .append("Statuts des validations :\n")
                .append("- Responsable hiérarchique : ").append(autorisation.getValidationResponsableHierarchique()).append("\n")
                .append("- Responsable RH : ").append(autorisation.getValidationResponsableRH()).append("\n")
                .append("- Chef sécurité : ").append(autorisation.getValidationChefSecurite()).append("\n\n")
                .append("Merci de bien vouloir consulter l'application pour valider cette demande.\n\n")
                .append("👉 Consulter et valider la demande ici :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nService RH");

        return sb.toString();
    }



    public Autorisation modifierAutorisation(Long id, Autorisation details) {
        Autorisation autorisation = autorisationRepository.findById(id).orElse(null);
        if (autorisation != null) {
            autorisation.setDate(details.getDate());
            autorisation.setMotif(details.getMotif());
            autorisation.setType(details.getType());

            autorisation.setHeureDebut(details.getHeureDebut());
            autorisation.setHeureFin(details.getHeureFin());
            autorisation.setDirection(details.getDirection());


            return autorisationRepository.save(autorisation);
        }
        return null;
    }

    public void supprimerAutorisation(Long id) {
        autorisationRepository.deleteById(id);
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

    public Autorisation changerStatutParRole(Long id, String role, String decision, String motifRefus, String matriculeValideur) {
        Autorisation aut = autorisationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Autorisation non trouvée"));

        String roleNettoye = role == null ? "" : role.trim();
        boolean estResponsableRH = roleNettoye.equalsIgnoreCase("Responsable RH");
        boolean estChefSecurite = roleNettoye.equalsIgnoreCase("Sécurité")
                || roleNettoye.equalsIgnoreCase("Gardien")
                || roleNettoye.equalsIgnoreCase("GARDIEN");
        boolean estResponsableHierarchique = isValidatorOrHierarchicalRole(roleNettoye);


        Employe targetEmploye = aut.getEmploye();
        if (targetEmploye == null) {
            throw new RuntimeException("Employé cible introuvable pour cette autorisation.");
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

        // 2. Validation par rôle

        // ─── A. VALIDEUR DE SÉCURITÉ ───
        if (estChefSecurite) {
            // Un agent de sécurité ne peut pas valider sa propre demande
            if (targetEmploye.getMatricule().equalsIgnoreCase(valideur.getMatricule())) {
                throw new RuntimeException("Vous ne pouvez pas valider votre propre demande d'autorisation.");
            }
            if (!"Accepté".equals(aut.getValidationResponsableRH())) {
                throw new RuntimeException("Responsable RH doit valider d'abord");
            }
            if (!"En attente".equals(aut.getValidationChefSecurite())) {
                throw new RuntimeException("Déjà validé par Chef Sécurité");
            }
            aut.setValidationChefSecurite(decision);
            if ("Refusé".equalsIgnoreCase(decision)) {
                aut.setMotifRefus(motifRefus != null ? motifRefus : "Aucun motif spécifié");
            }

            envoyerEmailRH_ApresValidationChefSecurite(aut, decision, roleNettoye);
        }

        // ─── B. RESPONSABLE RH ───
        else if (estResponsableRH && !valideur.getMatricule().equals("1")) {
            // Un RH ne peut pas valider sa propre demande
            if (targetEmploye.getMatricule().equalsIgnoreCase(valideur.getMatricule())) {
                throw new RuntimeException("Vous ne pouvez pas valider votre propre demande d'autorisation.");
            }
            if (!"Accepté".equals(aut.getValidationResponsableHierarchique())) {
                throw new RuntimeException("Le Responsable Hiérarchique doit valider en premier");
            }
            if (!"En attente".equals(aut.getValidationResponsableRH())) {
                throw new RuntimeException("Déjà validé par RH");
            }
            aut.setValidationResponsableRH(decision);
            if ("Refusé".equalsIgnoreCase(decision)) {
                aut.setMotifRefus(motifRefus != null ? motifRefus : "Aucun motif spécifié");
            }
        }

        // ─── C. RESPONSABLE HIÉRARCHIQUE ───
        else if (estResponsableHierarchique || valideur.getMatricule().equals("1")) {
            // Check self-request
            boolean isSelfRequest = targetEmploye.getMatricule().equalsIgnoreCase(valideur.getMatricule());

            if (isSelfRequest) {
                // Seul le matricule 1 peut valider sa propre demande
                if (!valideur.getMatricule().equals("1")) {
                    throw new RuntimeException("Vous ne pouvez pas valider votre propre demande d'autorisation. Elle doit être validée par le matricule 1.");
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

            if (!"En attente".equals(aut.getValidationResponsableHierarchique())) {
                throw new RuntimeException("Déjà validé par Responsable Hiérarchique");
            }

            aut.setValidationResponsableHierarchique(decision);
            if ("Refusé".equalsIgnoreCase(decision)) {
                aut.setMotifRefus(motifRefus != null ? motifRefus : "Aucun motif spécifié");
            }

            // Si c'est un auto-congé de RH, pas besoin d'étape RH supplémentaire
            if ("Accepté".equalsIgnoreCase(decision) && targetEmploye.getRole() != null && targetEmploye.getRole().equalsIgnoreCase("Responsable RH")) {
                aut.setValidationResponsableRH("Accepté");
            }

            envoyerEmailRH_ApresValidationHierarchique(aut, decision, roleNettoye);
        }

        // ─── D. AUTRES RÔLES NON AUTORISÉS ───
        else {
            throw new RuntimeException("Rôle non autorisé à valider");
        }


        mettreAJourStatutGlobal(aut);
        return autorisationRepository.save(aut);
    }
    private void envoyerEmailRH_ApresValidationChefSecurite(Autorisation aut, String decision, String valideur) {
        String nomEmploye = aut.getEmploye() != null ? aut.getEmploye().getFullname() : "N/A";
        String matricule = aut.getEmploye() != null ? aut.getEmploye().getMatricule() : "N/A";
        String emailRH = "seifeddine.Kmilete@topnet.tn"; // Email responsable RH cible

        String sujet = "Validation par le Chef Sécurité : " + nomEmploye;
        StringBuilder contenu = new StringBuilder();
        contenu.append("Bonjour RH,\n\n")
                .append("Le Chef Sécurité **").append(valideur).append("** a **")
                .append(decision.toUpperCase()).append("** la demande d'autorisation de :\n")
                .append("- Employé : ").append(nomEmploye).append("\n")
                .append("- Matricule : ").append(matricule).append("\n")
                .append("- Type : ").append(aut.getType()).append("\n")
                .append("- Date : ").append(aut.getDate()).append("\n")
                .append("- Direction : ").append(aut.getDirection()).append("\n\n");

        if ("Refusé".equalsIgnoreCase(decision)) {
            contenu.append("❗ Motif du refus : ").append(aut.getMotifRefus() != null ? aut.getMotifRefus() : "Non précisé").append("\n");
        }

        contenu.append("👉 Connectez-vous pour valider ou refuser cette demande côté RH :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nSystème de Gestion des Autorisations");

        emailService.envoyerEmail(
                Collections.singletonList(emailRH),
                sujet,
                contenu.toString()
        );
    }

    private void envoyerEmailRH_ApresValidationHierarchique(Autorisation autorisation, String decision, String valideur) {
        String nomEmploye = autorisation.getEmploye() != null ? autorisation.getEmploye().getFullname() : "N/A";
        String matricule = autorisation.getEmploye() != null ? autorisation.getEmploye().getMatricule() : "N/A";
        String emailRH = "seifeddine.Kmilete@topnet.tn"; // Email responsable RH fixe

        String sujet = "Validation par le Responsable Hiérarchique : " + nomEmploye;
        StringBuilder contenu = new StringBuilder();
        contenu.append("Bonjour RH,\n\n")
                .append("Le Responsable Hiérarchique **").append(valideur).append("** a **")
                .append(decision.toUpperCase()).append("** la demande d'autorisation de :\n")
                .append("- Employé : ").append(nomEmploye).append("\n")
                .append("- Matricule : ").append(matricule).append("\n")
                .append("- Type : ").append(autorisation.getType()).append("\n")
                .append("- Date : ").append(autorisation.getDate()).append("\n")
                .append("- Direction : ").append(autorisation.getDirection()).append("\n\n");

        if ("Refusé".equalsIgnoreCase(decision)) {
            contenu.append("❗ Motif du refus : ").append(autorisation.getMotifRefus() != null ? autorisation.getMotifRefus() : "Non précisé").append("\n");
        }


        contenu.append("👉 Connectez-vous pour valider ou refuser cette demande côté RH :\n")
                .append("https://kktdigital.netlify.app\n\n")
                .append("Cordialement,\nSystème de Gestion des Autorisations");

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
                "Responsable Unité de production",
                "Chef Service Cable",
                "Responsable Qualité",
                "Validateur Supérieur Hiérarchique",
                "Responsable Production",
                "Chef Service couture",
                "Chef service technique",
                "Responsable RH",
                "Responsable AV"
        );
        return roles.stream().anyMatch(r -> r.equalsIgnoreCase(role.trim()));
    }

    private void mettreAJourStatutGlobal(Autorisation aut) {
        if (
                "Refusé".equals(aut.getValidationResponsableHierarchique()) ||
                        "Refusé".equals(aut.getValidationResponsableRH()) ||
                        "Refusé".equals(aut.getValidationChefSecurite())
        ) {
            aut.setStatut("Refusé");
        } else if (
                "Accepté".equals(aut.getValidationResponsableHierarchique()) &&
                        "Accepté".equals(aut.getValidationResponsableRH()) &&
                        "Accepté".equals(aut.getValidationChefSecurite())
        ) {
            aut.setStatut("Accepté");
        } else {
            aut.setStatut("En attente");
        }
    }
    public List<Autorisation> getTopAutorisations() {
        return autorisationRepository.findAll(Sort.by(Sort.Direction.DESC, "date"));
    }


}

