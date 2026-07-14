import { ConfirmService } from '../services/confirm.service';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { of, catchError, debounceTime, distinctUntilChanged, switchMap } from 'rxjs';

import { AnomalieServiceService } from '../services/anomalie-service.service';
import { EmployeService } from '../services/employe.service';
import { AuthServiceService } from '../services/auth-service.service';

@Component({
  selector: 'app-anomalie-pointage',
  standalone: true,
  imports: [ReactiveFormsModule, CommonModule, FormsModule],
  templateUrl: './anomalie-pointage.component.html',
  styleUrls: ['./anomalie-pointage.component.css']
})
export class AnomaliePointageComponent implements OnInit {
  form!: FormGroup;
  anomalies: any[] = [];
  allAnomalies: any[] = [];

  successMessage = '';
  errorMessage = '';
  nomEmploye: string | null = null;

  searchTerm: string = '';
  currentPage = 1;
  itemsPerPage = 10;
  totalPages = 0;

  userRole: string = '';
  userZone: string = '';
  isEditMode = false;
  editId: number | null = null;

  searchMatricule: string = '';
  searchTypeAnomalie: string = '';
  searchZone: string = '';
  searchStatut: string = '';

  constructor(private fb: FormBuilder,
    private anomalieService: AnomalieServiceService,
    private employeService: EmployeService,
    private authService: AuthServiceService, private confirmService: ConfirmService) {}

  ngOnInit(): void {
    this.form = this.fb.group({
      matricule: ['', Validators.required],
      typeAnomalie: ['ENTREE', Validators.required],
      remarque: [''],
      statut: ['En attente'] // ✅ ajouté
    });

    this.authService.userRole$.subscribe(role => {
      this.userRole = role;
      this.appliquerFiltrageEtPagination();
    });

    this.authService.userZone$.subscribe(zone => {
      this.userZone = zone;
      this.appliquerFiltrageEtPagination();
    });

    this.form.get('matricule')?.valueChanges.pipe(
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
    ).subscribe(employe => {
      this.nomEmploye = employe ? employe.fullname : null;
    });

    this.chargerAnomalies();
  }

  chargerAnomalies() {
    const userRole = this.authService.getRoleFromStorage()?.trim().toLowerCase();
    const zonesUtilisateur = this.authService.getZonesList().map(z => z.trim().toLowerCase());

    this.anomalieService.getAll().subscribe({
      next: data => {
        if (userRole === 'responsable rh' || userRole === 'chef securite' || userRole === 'sécurité') {
          this.allAnomalies = data.reverse();
        } else if (userRole === 'directeur') {
          this.allAnomalies = data.filter(a => {
            const zone = (a.employe?.zone || '').trim().toLowerCase().replace(/\s*\/\s*/g, '/');
            return zone === 'administration' || zone.startsWith('administration/');
          }).reverse();
        } else {
          this.allAnomalies = data.filter(a => {
            const zoneEmploye = (a.employe?.zone || '').trim().toLowerCase();
            return zonesUtilisateur.includes(zoneEmploye);
          }).reverse();
        }

        this.appliquerFiltrageEtPagination();
      },
      error: err => console.error('Erreur chargement anomalies', err)
    });
  }

  appliquerFiltrageEtPagination() {
    if (!this.allAnomalies.length || !this.userRole) return;

    let filtered = this.allAnomalies;

    if (this.searchTerm.trim()) {
      const term = this.searchTerm.toLowerCase();
      filtered = filtered.filter(a =>
        a.employe?.matricule?.toLowerCase().includes(term) ||
        a.employe?.fullname?.toLowerCase().includes(term) ||
        a.typeAnomalie?.toLowerCase().includes(term) ||
        a.statut?.toLowerCase().includes(term)
      );
    }

    this.totalPages = Math.ceil(filtered.length / this.itemsPerPage);
    if (this.currentPage > this.totalPages) this.currentPage = this.totalPages || 1;

    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    this.anomalies = filtered.slice(startIndex, startIndex + this.itemsPerPage);
  }

  onSearchChange() {
    this.currentPage = 1;
    this.appliquerFiltrageEtPagination();
  }

  changerPage(page: number) {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.appliquerFiltrageEtPagination();
    }
  }

  get pagesArray(): number[] {
    return Array.from({ length: this.totalPages }, (_, i) => i + 1);
  }

  envoyer() {
    if (this.form.invalid) return;

    this.successMessage = '';
    this.errorMessage = '';

    const anomaliePayload = {
      typeAnomalie: this.form.value.typeAnomalie,
      remarque: this.form.value.remarque,
      statut: this.form.value.statut, // ✅ important
      employe: { matricule: this.form.value.matricule }
    };

    if (this.isEditMode && this.editId !== null) {
      this.anomalieService.modifier(this.editId, anomaliePayload).subscribe({
        next: () => {
          this.successMessage = 'Anomalie modifiée avec succès.';
          this.errorMessage = '';
          this.isEditMode = false;
          this.editId = null;
          this.form.reset({ typeAnomalie: 'ENTREE', statut: 'En attente' });
          this.nomEmploye = null;
          this.chargerAnomalies();
        },
        error: () => {
          this.errorMessage = 'Erreur lors de la modification de l\'anomalie.';
          this.successMessage = '';
        }
      });
    } else {
      this.anomalieService.ajouter(anomaliePayload).subscribe({
        next: () => {
          this.successMessage = 'Anomalie signalée avec succès.';
          this.errorMessage = '';
          this.nomEmploye = null;
          this.form.reset({ typeAnomalie: 'ENTREE', statut: 'En attente' });
          this.chargerAnomalies();
        },
        error: () => {
          this.errorMessage = 'Erreur lors de l\'envoi de l\'anomalie.';
          this.successMessage = '';
        }
      });
    }
  }

  changerStatut(id: number, statut: string) {
    this.anomalieService.changerStatut(id, statut).subscribe(() => this.chargerAnomalies());
  }

  supprimer(id: number) {
    this.confirmService.confirm('Voulez-vous vraiment supprimer cette anomalie ?').then(res => {
      if (res) {
        this.anomalieService.supprimer(id).subscribe(() => this.chargerAnomalies());
      }
    });
  }

  modifier(anomalie: any) {
    this.isEditMode = true;
    this.editId = anomalie.id;

    this.form.patchValue({
      matricule: anomalie.employe?.matricule || '',
      typeAnomalie: anomalie.typeAnomalie,
      remarque: anomalie.remarque,
      statut: anomalie.statut // ✅ pour conserver le statut
    });
  }

  filtrerEtAfficherAnomalies() {
    if (!this.allAnomalies?.length) return;

    let filtered = this.allAnomalies;

    if (this.searchMatricule?.trim()) {
      filtered = filtered.filter(a =>
        a.employe?.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase())
      );
    }

    if (this.searchTypeAnomalie?.trim()) {
      filtered = filtered.filter(a => a.typeAnomalie === this.searchTypeAnomalie);
    }

    if (this.searchZone?.trim()) {
      filtered = filtered.filter(a =>
        a.employe?.zone?.toLowerCase().includes(this.searchZone.toLowerCase())
      );
    }

    if (this.searchStatut?.trim()) {
      filtered = filtered.filter(a => a.statut === this.searchStatut);
    }

    this.totalPages = Math.ceil(filtered.length / this.itemsPerPage);
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    this.anomalies = filtered.slice(startIndex, startIndex + this.itemsPerPage);
  }

  resetRecherche() {
    this.searchMatricule = '';
    this.searchTypeAnomalie = '';
    this.searchZone = '';
    this.searchStatut = '';
    this.currentPage = 1;
    this.filtrerEtAfficherAnomalies();
  }
}
