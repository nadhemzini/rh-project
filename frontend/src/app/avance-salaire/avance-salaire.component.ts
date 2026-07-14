import { ConfirmService } from '../services/confirm.service';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AuthServiceService } from '../services/auth-service.service';
import { AvanceServiceService } from '../services/avance-service.service';
import { EmployeService } from '../services/employe.service';
import { catchError, debounceTime, distinctUntilChanged, of, switchMap } from 'rxjs';

@Component({
  selector: 'app-avance-salaire',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './avance-salaire.component.html',
  styleUrl: './avance-salaire.component.css'
})
export class AvanceSalaireComponent implements OnInit {
  form!: FormGroup;

  demandes: any[] = [];
  allDemandes: any[] = [];
  nomEmploye: string | null = null;


  successMessage = '';
  errorMessage = '';

  userRole = '';
  userZone = '';

  searchTerm = '';

  currentPage = 1;
  itemsPerPage = 10;
  totalPages = 0;

  isEditMode: boolean = false;
editId: number | null = null;

 searchMatricule: string = '';
  searchNom: string = '';
  searchStatut: string = '';
  searchZone: string = '';
  

  constructor(private fb: FormBuilder,
    private avanceService: AvanceServiceService,
    private authService: AuthServiceService,
      private employeService: EmployeService, private confirmService: ConfirmService) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      matricule: ['', Validators.required],
      montant: [null, [Validators.required, Validators.min(1)]],
      remarque: ['']
    });

    // Récupération du rôle et zone utilisateur
    this.authService.userRole$.subscribe(role => {
      this.userRole = role;
      this.filtrerEtAfficherDemandes();
    });
    this.authService.userZone$.subscribe(zone => {
      this.userZone = zone;
      this.filtrerEtAfficherDemandes();
    });
    this.form.get('matricule')?.valueChanges
    .pipe(
      debounceTime(500),
      distinctUntilChanged(),
      switchMap(matricule => {
        if (!matricule) {
          this.nomEmploye = null;
          return of(null);
        }
        return this.employeService.getEmployeByMatricule(matricule).pipe(
          catchError(() => {
            this.nomEmploye = null;
            return of(null);
          })
        );
      })
    )
    .subscribe(employe => {
      if (employe) {
        this.nomEmploye = employe.fullname; // selon ta structure
      } else {
        this.nomEmploye = null;
      }
    });

  this.chargerDemandes();

    this.chargerDemandes();
  }

 chargerDemandes() {
  const userRole = this.authService.getRoleFromStorage()?.trim().toLowerCase();
  const zonesUtilisateur = this.authService.getZonesList().map(z => z.trim().toLowerCase());

  this.avanceService.getAll().subscribe({
    next: data => {
      if (userRole === 'responsable rh' || userRole === 'sécurité') {
        // Responsable RH et Sécurité voient toutes les demandes
        this.allDemandes = data.reverse();

      } else if (userRole === 'directeur') {
        // Directeur voit uniquement les zones administration
        this.allDemandes = data.filter(demande => {
          const zone = (demande.employe?.zone || '').trim().toLowerCase().replace(/\s*\/\s*/g, '/');
          return zone === 'administration' || zone.startsWith('administration/');
        }).reverse();

      } else {
        // Les autres utilisateurs voient uniquement les zones autorisées
        this.allDemandes = data.filter(demande => {
          const zoneEmploye = (demande.employe?.zone || '').trim().toLowerCase();
          return zonesUtilisateur.includes(zoneEmploye);
        }).reverse();
      }

      this.filtrerEtAfficherDemandes(); // ou tout autre post-traitement
    },
    error: err => console.error('Erreur chargement demandes avances:', err)
  });
}




filtrerEtAfficherDemandes() {
  if (!this.allDemandes.length || !this.userRole) return;

  let filtered = this.allDemandes;



  if (this.searchMatricule?.trim()) {
    filtered = filtered.filter(d => d.employe?.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase()));
  }

  if (this.searchNom?.trim()) {
    filtered = filtered.filter(d => d.employe?.fullname?.toLowerCase().includes(this.searchNom.toLowerCase()));
  }

  if (this.searchStatut?.trim()) {
    filtered = filtered.filter(d => d.statut === this.searchStatut);
  }

  if (this.searchZone?.trim()) {
    filtered = filtered.filter(d => d.employe?.zone?.toLowerCase().includes(this.searchZone.toLowerCase()));
  }

  this.totalPages = Math.ceil(filtered.length / this.itemsPerPage);
  const startIndex = (this.currentPage - 1) * this.itemsPerPage;
  this.demandes = filtered.slice(startIndex, startIndex + this.itemsPerPage);
}

resetRecherche() {
  this.searchMatricule = '';
  this.searchNom = '';
  this.searchStatut = '';
  this.searchZone = '';
  this.currentPage = 1;
  this.filtrerEtAfficherDemandes();
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

envoyer() {
  if (this.form.invalid) return;

  const demande = {
    employe: { matricule: this.form.value.matricule },
    montant: this.form.value.montant,
    remarque: this.form.value.remarque
  };

  if (this.isEditMode && this.editId) {
    // Modifier la demande
    this.avanceService.modifier(this.editId, demande).subscribe({
      next: () => {
        this.successMessage = 'Demande modifiée avec succès.';
        this.errorMessage = '';
        this.resetForm();
        this.chargerDemandes();
      },
      error: () => {
        this.errorMessage = 'Erreur lors de la modification de la demande.';
        this.successMessage = '';
      }
    });
  } else {
    // Ajouter nouvelle demande
    this.avanceService.ajouterAvance(demande).subscribe({
      next: () => {
        this.successMessage = 'Demande envoyée avec succès.';
        this.errorMessage = '';
        this.resetForm();
        this.chargerDemandes();
      },
      error: () => {
        this.errorMessage = 'Erreur lors de l\'envoi de la demande.';
        this.successMessage = '';
      }
    });
  }
}
resetForm() {
  this.form.reset();
  this.isEditMode = false;
  this.editId = null;
  this.nomEmploye = null;
}
preparerModification(demande: any) {
  this.isEditMode = true;
  this.editId = demande.id;

  this.form.patchValue({
    matricule: demande.employe?.matricule,
    montant: demande.montant,
    remarque: demande.remarque
  });

  this.nomEmploye = demande.employe?.fullname || null;
}


  changerStatut(id: number, statut: string) {
    this.avanceService.changerStatut(id, statut).subscribe({
      next: () => {
        this.successMessage = `Statut changé en "${statut}" avec succès.`;
        this.errorMessage = '';
        this.chargerDemandes();
      },
      error: () => {
        this.errorMessage = 'Erreur lors du changement de statut.';
        this.successMessage = '';
      }
    });
  }

  supprimer(id: number) {
    this.confirmService.confirm('Voulez-vous vraiment supprimer cette demande ?').then(res => {
      if (res) {
      this.avanceService.supprimer(id).subscribe({
        next: () => {
          this.successMessage = 'Demande supprimée avec succès.';
          this.errorMessage = '';
          this.chargerDemandes();
        },
        error: () => {
          this.errorMessage = 'Erreur lors de la suppression.';
          this.successMessage = '';
        }
      });
      }
    });
  }

}
