package com.exemple.rh.Service;

import com.exemple.rh.Entity.DemandeDocument;
import com.exemple.rh.Entity.Employe;
import com.exemple.rh.Repository.DemandeDocumentRepository;
import com.exemple.rh.Repository.EmployeRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.contains;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class DemandeDocumentServiceTest {

    @Mock
    private DemandeDocumentRepository repository;

    @Mock
    private EmailService emailService;

    @Mock
    private EmployeRepository employeRepository;

    @InjectMocks
    private DemandeDocumentService service;

    @Test
    void ajouterRejectsRequestsWithoutMatricule() {
        DemandeDocument demande = new DemandeDocument();
        demande.setEmploye(new Employe());

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> service.ajouter(demande));

        assertEquals("Le matricule de l'employé est requis.", exception.getMessage());
        verifyNoInteractions(repository, emailService, employeRepository);
    }

    @Test
    void ajouterSavesRequestAndTriggersEmail() {
        Employe employe = new Employe();
        employe.setMatricule("M-100");
        employe.setFullname("Amina Benali");
        employe.setRole("USER");

        DemandeDocument demande = new DemandeDocument();
        demande.setTypeDocument("Attestation de travail");
        Employe requestedEmploye = new Employe();
        requestedEmploye.setMatricule("M-100");
        demande.setEmploye(requestedEmploye);

        when(employeRepository.findByMatricule("M-100")).thenReturn(Optional.of(employe));
        when(repository.save(any(DemandeDocument.class))).thenAnswer(invocation -> invocation.getArgument(0));

        DemandeDocument saved = service.ajouter(demande);

        assertEquals(LocalDate.now(), saved.getDateDemande());
        assertEquals("En attente", saved.getStatut());
        assertSame(employe, saved.getEmploye());
        verify(emailService).envoyerEmail(
                eq(List.of("seifeddine.Kmilete@topnet.tn")),
                eq("Nouvelle Demande de Document Administratif"),
                contains("Attestation de travail")
        );
    }

    @Test
    void ajouterFailsWhenEmployeDoesNotExist() {
        DemandeDocument demande = new DemandeDocument();
        Employe requestedEmploye = new Employe();
        requestedEmploye.setMatricule("M-200");
        demande.setEmploye(requestedEmploye);

        when(employeRepository.findByMatricule("M-200")).thenReturn(Optional.empty());

        RuntimeException exception = assertThrows(RuntimeException.class, () -> service.ajouter(demande));

        assertEquals("Employé introuvable avec le matricule : M-200", exception.getMessage());
        verify(repository, never()).save(any());
        verifyNoInteractions(emailService);
    }

    @Test
    void getAllDelegatesToRepository() {
        List<DemandeDocument> demandes = List.of(new DemandeDocument());
        when(repository.findAll()).thenReturn(demandes);

        assertSame(demandes, service.getAll());
        verify(repository).findAll();
    }

    @Test
    void getByEmployeDelegatesToRepository() {
        List<DemandeDocument> demandes = List.of(new DemandeDocument());
        when(repository.findByEmployeMatricule("M-100")).thenReturn(demandes);

        assertSame(demandes, service.getByEmploye("M-100"));
        verify(repository).findByEmployeMatricule("M-100");
    }

    @Test
    void changerStatutUpdatesStatusAndRemark() {
        DemandeDocument existing = new DemandeDocument();
        existing.setId(1L);
        existing.setStatut("En attente");

        when(repository.findById(1L)).thenReturn(Optional.of(existing));
        when(repository.save(any(DemandeDocument.class))).thenAnswer(invocation -> invocation.getArgument(0));

        DemandeDocument result = service.changerStatut(1L, "Acceptée", "Validée");

        assertEquals("Acceptée", result.getStatut());
        assertEquals("Validée", result.getRemarque());
        verify(repository).save(existing);
    }

    @Test
    void modifierUpdatesFieldsAndRebindsEmployeWhenMatriculeIsProvided() {
        DemandeDocument existing = new DemandeDocument();
        existing.setId(1L);
        existing.setTypeDocument("Ancien");
        existing.setRemarque("Ancienne remarque");

        Employe linkedEmploye = new Employe();
        linkedEmploye.setMatricule("M-300");

        when(repository.findById(1L)).thenReturn(Optional.of(existing));
        when(employeRepository.findByMatricule("M-300")).thenReturn(Optional.of(linkedEmploye));
        when(repository.save(any(DemandeDocument.class))).thenAnswer(invocation -> invocation.getArgument(0));

        DemandeDocument updated = new DemandeDocument();
        updated.setTypeDocument("Nouveau");
        updated.setRemarque("Nouvelle remarque");
        Employe updatedEmploye = new Employe();
        updatedEmploye.setMatricule("M-300");
        updated.setEmploye(updatedEmploye);

        DemandeDocument result = service.modifier(1L, updated);

        assertEquals("Nouveau", result.getTypeDocument());
        assertEquals("Nouvelle remarque", result.getRemarque());
        assertSame(linkedEmploye, result.getEmploye());
        verify(repository).save(existing);
    }

    @Test
    void supprimerDeletesWhenDemandeExists() {
        when(repository.existsById(1L)).thenReturn(true);

        service.supprimer(1L);

        verify(repository).deleteById(1L);
    }

    @Test
    void supprimerFailsWhenDemandeIsMissing() {
        when(repository.existsById(1L)).thenReturn(false);

        RuntimeException exception = assertThrows(RuntimeException.class, () -> service.supprimer(1L));

        assertEquals("Demande introuvable avec l'ID : 1", exception.getMessage());
        verify(repository, never()).deleteById(anyLong());
    }
}
