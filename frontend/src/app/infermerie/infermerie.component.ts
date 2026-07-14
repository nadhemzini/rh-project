import { Component, OnInit } from '@angular/core';
import { InfermerieService } from '../services/infermerie.service';
import { EmployeService } from '../services/employe.service';
import { AuthServiceService } from '../services/auth-service.service';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-infermerie',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule],
  templateUrl: './infermerie.component.html',
  styleUrls: ['./infermerie.component.css']
})
export class InfermerieComponent implements OnInit {
  userRole: string = '';
  visites: any[] = [];
  visitesAffichees: any[] = [];
  employes: any[] = [];
  nomEmploye: string = '';
  zoneEmploye: string = '';

  newVisite = {
    date: '',
    type: '',
    motif: '',
    employe: { matricule: '' },
    statut: 'En attente'
  };

  isEditMode: boolean = false;
  editId: number | null = null;

  searchMatricule: string = '';
  searchZone: string = '';
  searchType: string = '';
  searchStatut: string = '';
  searchDate: string = '';

  constructor(
    private infermerieService: InfermerieService,
    private employeService: EmployeService,
    private authService: AuthServiceService
  ) {}

  ngOnInit(): void {
    this.loadVisites();
    this.loadEmployes();
    this.userRole = this.authService.getRoleFromStorage()?.toLowerCase() || '';
  }

  filtrer(): void {
    this.visitesAffichees = this.visites.filter(v =>
      (!this.searchMatricule || v.employe?.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase())) &&
      (!this.searchZone || v.employe?.zone?.toLowerCase().includes(this.searchZone.toLowerCase())) &&
      (!this.searchType || v.type?.toLowerCase().includes(this.searchType.toLowerCase())) &&
      (!this.searchStatut || v.statut === this.searchStatut) &&
      (!this.searchDate || new Date(v.date) >= new Date(this.searchDate))
    );
  }

  resetRecherche(): void {
    this.searchMatricule = '';
    this.searchZone = '';
    this.searchType = '';
    this.searchStatut = '';
    this.searchDate = '';
    this.visitesAffichees = [...this.visites];
  }

  loadVisites(): void {
    this.infermerieService.getAll().subscribe(data => {
      this.visites = data.reverse();
      this.visitesAffichees = [...this.visites];
    });
  }

  loadEmployes(): void {
    this.employeService.getAllEmployes().subscribe(data => {
      this.employes = data;
      console.log('Employés chargés :', this.employes); // Debug
    });
  }

  remplirNomEtZone(): void {
    const matricule = this.newVisite.employe.matricule.trim().toLowerCase();
    if (!matricule) {
      this.nomEmploye = '';
      this.zoneEmploye = '';
      return;
    }
    const emp = this.employes.find(e => e.matricule?.trim().toLowerCase() === matricule);
    if (emp) {
      this.nomEmploye = emp.fullname || '';
      this.zoneEmploye = emp.zone || '';
      // Ne pas remplacer tout l'objet pour éviter conflits avec ngModel
      this.newVisite.employe.matricule = emp.matricule;
    } else {
      this.nomEmploye = '';
      this.zoneEmploye = '';
      // Garde le matricule saisi
      this.newVisite.employe.matricule = this.newVisite.employe.matricule;
    }
  }

  addVisite(): void {
    const data = { ...this.newVisite };

    if (this.isEditMode && this.editId !== null) {
      this.infermerieService.update(this.editId, data).subscribe(() => {
        this.loadVisites();
        this.resetForm();
      });
    } else {
      this.infermerieService.add(data).subscribe(() => {
        this.loadVisites();
        this.resetForm();
      });
    }
  }

  modifier(visite: any): void {
    this.isEditMode = true;
    this.editId = visite.id;
    this.newVisite = {
      type: visite.type,
      motif: visite.motif,
      date: visite.date,
      employe: { matricule: visite.employe?.matricule || '' },
      statut: visite.statut || 'En attente'
    };
    this.remplirNomEtZone();
  }

  annulerModification(): void {
    this.resetForm();
  }

  deleteVisite(id: number): void {
    this.infermerieService.delete(id).subscribe(() => {
      this.loadVisites();
    });
  }

  changerStatut(id: number, statut: string): void {
    this.infermerieService.changerStatut(id, statut).subscribe(() => {
      this.loadVisites();
    });
  }

  resetForm(): void {
    this.newVisite = {
      date: '',
      type: '',
      motif: '',
      employe: { matricule: '' },
      statut: 'En attente'
    };
    this.nomEmploye = '';
    this.zoneEmploye = '';
    this.isEditMode = false;
    this.editId = null;
  }
}
