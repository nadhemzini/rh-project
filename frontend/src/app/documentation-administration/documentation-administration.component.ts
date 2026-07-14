import { ConfirmService } from '../services/confirm.service';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { of, catchError, debounceTime, distinctUntilChanged, switchMap } from 'rxjs';

import { DemandeDocumentService } from '../services/demande-document.service';
import { EmployeService } from '../services/employe.service';
import { AuthServiceService } from '../services/auth-service.service';

@Component({
  selector: 'app-documentation-administration',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './documentation-administration.component.html',
  styleUrls: ['./documentation-administration.component.css']
})
export class DocumentationAdministrationComponent implements OnInit {
  form!: FormGroup;
  successMessage = '';
  errorMessage = '';
  nomEmploye: string | null = null;

  demandes: any[] = [];
  allDemandes: any[] = [];

  modifierMode: boolean = false;
  demandeIdEnCours: number | null = null;

  userRole: string = '';
  userZone: string = '';

  currentPage = 1;
  itemsPerPage = 5;
  totalPages = 0;

  searchTerm: string = '';
  searchMatricule: string = '';
searchNom: string = '';
searchType: string = '';
searchStatut: string = '';
searchZone: string = '';
searchTypeDocument: string = '';


  constructor(private fb: FormBuilder,
    private demandeService: DemandeDocumentService,
    private employesService: EmployeService,
    private authService: AuthServiceService, private confirmService: ConfirmService) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      typeDocument: ['', Validators.required],
      typeDocumentAutre: [''],
      matricule: ['', Validators.required],
      remarque: ['']
    });

    this.authService.userRole$.subscribe(role => {
      this.userRole = role;
      this.filtrerEtAfficherDemandes(); // déclencher si déjà chargées
    });

    this.authService.userZone$.subscribe(zone => {
      this.userZone = zone;
      this.filtrerEtAfficherDemandes(); // déclencher si déjà chargées
    });

    this.form.get('typeDocument')?.valueChanges.subscribe(value => {
      const autreControl = this.form.get('typeDocumentAutre');
      if (value === 'Autre') {
        autreControl?.setValidators([Validators.required]);
      } else {
        autreControl?.clearValidators();
        autreControl?.setValue('');
      }
      autreControl?.updateValueAndValidity();
    });

    this.form.get('matricule')?.valueChanges.pipe(
      debounceTime(500),
      distinctUntilChanged(),
      switchMap(matricule => {
        if (!matricule) {
          this.nomEmploye = null;
          return of(null);
        }
        return this.employesService.getEmployeByMatricule(matricule).pipe(
          catchError(() => {
            this.nomEmploye = null;
            return of(null);
          })
        );
      })
    ).subscribe(employe => {
      this.nomEmploye = employe ? employe.fullname : null;
    });

    this.chargerDemandes();
  }
resetRecherche() {
  this.searchMatricule = '';
  this.searchNom = '';
  this.searchType = '';
  this.searchStatut = '';
  this.searchZone = '';
  this.currentPage = 1;
   this.searchTypeDocument = '';
  this.filtrerEtAfficherDemandes();
}

 chargerDemandes() {
  const userRole = this.authService.getRoleFromStorage()?.trim().toLowerCase();
  const zonesUtilisateur = this.authService.getZonesList().map(z => z.trim().toLowerCase());

  this.demandeService.getAllDemandes().subscribe({
    next: data => {
      if (userRole === 'responsable rh' || userRole === 'gardien' || userRole === 'sécurité') {
        this.allDemandes = data.reverse();

      } else if (userRole === 'directeur') {
        this.allDemandes = data.filter(d => {
          const zone = (d.employe?.zone || '').trim().toLowerCase();
          return zone === 'administration' || zone.startsWith('administration/');
        }).reverse();

      } else {
        this.allDemandes = data.filter(d => {
          const zoneEmploye = (d.employe?.zone || '').trim().toLowerCase();
          return zonesUtilisateur.includes(zoneEmploye);
        }).reverse();
      }

      this.filtrerEtAfficherDemandes();
    },
    error: err => {
      console.error('Erreur chargement demandes', err);
    }
  });
}



 filtrerEtAfficherDemandes() {
  if (!this.allDemandes.length || !this.userRole) return;

  let filtered = this.allDemandes;

  // Filtrage par rôle et zone
  
  // Filtres multiples
  if (this.searchMatricule) {
    filtered = filtered.filter(d => d.employe?.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase()));
  }

  if (this.searchNom) {
    filtered = filtered.filter(d => d.employe?.fullname?.toLowerCase().includes(this.searchNom.toLowerCase()));
  }

 if (this.searchTypeDocument) {
  filtered = filtered.filter(d =>
    d.typeDocument?.toLowerCase() === this.searchTypeDocument.toLowerCase()
  );
}


  if (this.searchStatut) {
    filtered = filtered.filter(d => d.statut?.toLowerCase() === this.searchStatut.toLowerCase());
  }

  if (this.searchZone) {
    filtered = filtered.filter(d => d.employe?.zone?.toLowerCase().includes(this.searchZone.toLowerCase()));
  }

  this.totalPages = Math.ceil(filtered.length / this.itemsPerPage);
  const startIndex = (this.currentPage - 1) * this.itemsPerPage;
  this.demandes = filtered.slice(startIndex, startIndex + this.itemsPerPage);
}


  onSearchChange() {
    this.currentPage = 1;
    this.filtrerEtAfficherDemandes();
  }

  changerPage(page: number) {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.filtrerEtAfficherDemandes();
    }
  }

  changerStatut(id: number, statut: string) {
    this.demandeService.changerStatut(id, statut).subscribe({
      next: () => {
        this.successMessage = `Statut changé en "${statut}" avec succès.`;
        this.errorMessage = '';
        this.chargerDemandes();
      },
      error: err => {
        this.errorMessage = 'Erreur lors du changement de statut.';
        this.successMessage = '';
        console.error(err);
      }
    });
  }

  envoyer() {
    if (this.form.invalid) return;

    const typeDoc = this.form.value.typeDocument === 'Autre'
      ? this.form.value.typeDocumentAutre
      : this.form.value.typeDocument;

    const demande = {
      typeDocument: typeDoc,
      remarque: this.form.value.remarque || '',
      employe: { matricule: this.form.value.matricule }
    };

    const requete = this.modifierMode && this.demandeIdEnCours !== null
      ? this.demandeService.modifierDemande(this.demandeIdEnCours, demande)
      : this.demandeService.ajouterDemande(demande);

    requete.subscribe({
      next: () => {
        this.successMessage = this.modifierMode ? 'Demande modifiée avec succès !' : 'Demande envoyée avec succès !';
        this.errorMessage = '';
        this.resetFormulaire();
        this.chargerDemandes();
      },
      error: err => {
        this.errorMessage = this.modifierMode ? 'Erreur lors de la modification.' : "Erreur lors de l'envoi.";
        this.successMessage = '';
        console.error(err);
      }
    });
  }

  remplirFormulairePourEdition(demande: any) {
    const typeDoc = demande.typeDocument;
    const standardTypes = ['Attestation de travail', 'Attestation de Présence', 'Certificat de salaire', 'Relevé de carrière'];

    this.form.patchValue({
      typeDocument: standardTypes.includes(typeDoc) ? typeDoc : 'Autre',
      typeDocumentAutre: standardTypes.includes(typeDoc) ? '' : typeDoc,
      matricule: demande.employe.matricule,
      remarque: demande.remarque
    });

    this.demandeIdEnCours = demande.id;
    this.nomEmploye = demande.employe.fullname;
    this.modifierMode = true;
  }

  supprimer(id: number) {
    this.confirmService.confirm('Voulez-vous vraiment supprimer cette demande ?').then(res => {
      if (res) {
      this.demandeService.supprimerDemande(id).subscribe({
        next: () => {
          this.successMessage = 'Demande supprimée avec succès.';
          this.errorMessage = '';
          this.chargerDemandes();
        },
        error: err => {
          this.errorMessage = 'Erreur lors de la suppression.';
          this.successMessage = '';
          console.error(err);
        }
      });
      }
    });
  }

  resetFormulaire() {
    this.form.reset();
    this.nomEmploye = null;
    this.modifierMode = false;
    this.demandeIdEnCours = null;
  }
}
