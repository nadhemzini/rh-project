import { ToastService } from '../services/toast.service';
import { Component, OnInit } from '@angular/core';
import { EmissionService } from '../services/emission.service';
import { EmployeService } from '../services/employe.service';
import { AuthServiceService } from '../services/auth-service.service';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-emission',
  standalone: true,
  imports: [CommonModule,FormsModule,ReactiveFormsModule],
  templateUrl: './emission.component.html',
  styleUrl: './emission.component.css'
})
export class EmissionComponent implements OnInit {
  userRole: string = '';
  emissions: any[] = [];
  emissionsAffichees: any[] = [];

  employes: any[] = [];
  nomEmploye: string = '';
  zoneEmploye: string = '';

  newEmission = {
  type: '',
  autreType: '',
  dateDebut: '',
  dateFin: '',
  employe: {
    matricule: ''
  },
  statut: 'En attente'
};


  isEditMode = false;
  editId: number | null = null;


  constructor(private emissionService: EmissionService,
    private employeService: EmployeService,
    private authService: AuthServiceService, private toastService: ToastService) {}

  ngOnInit(): void {
    this.loadEmissions();
    this.loadEmployes();
    this.userRole = this.authService.getRoleFromStorage()?.toLowerCase() || '';
  }
  searchMatricule = '';
searchZone = '';
searchType = '';
searchStatut = '';
searchDateDebut = '';
filtrer() {
  this.emissionsAffichees = this.emissions.filter(e =>
    (!this.searchMatricule || e.employe?.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase())) &&
    (!this.searchZone || e.employe?.zone?.toLowerCase().includes(this.searchZone.toLowerCase())) &&
    (!this.searchType || e.type?.toLowerCase().includes(this.searchType.toLowerCase())) &&
    (!this.searchStatut || e.statut === this.searchStatut)&&
    (!this.searchDateDebut || new Date(e.dateDebut) >= new Date(this.searchDateDebut))
  );
}

resetRecherche() {
  this.searchMatricule = '';
  this.searchZone = '';
  this.searchType = '';
  this.searchStatut = '';
   this.searchDateDebut = '';
  this.emissionsAffichees = [...this.emissions];
}


  loadEmissions() {
    this.emissionService.getAll().subscribe(data => {
      this.emissions = data.reverse();
      this.emissionsAffichees = [...this.emissions];
    });
  }

  loadEmployes() {
    this.employeService.getAllEmployes().subscribe(data => {
      this.employes = data;
    });
  }

  remplirNomEtZone() {
    const matricule = this.newEmission.employe.matricule;
    const emp = this.employes.find(e => e.matricule === matricule);
    if (emp) {
      this.nomEmploye = emp.fullname;
      this.zoneEmploye = emp.zone;
      this.newEmission.employe = emp; // envoie l'objet complet
    } else {
      this.nomEmploye = '';
      this.zoneEmploye = '';
      this.newEmission.employe = { matricule: '' };
    }
  }

  addEmission() {
     const dateAujourdhui = new Date();
  const dateDebut = new Date(this.newEmission.dateDebut);

  // Réinitialiser l'heure pour comparer uniquement les dates (sans l'heure)
  dateAujourdhui.setHours(0, 0, 0, 0);
  dateDebut.setHours(0, 0, 0, 0);

  if (dateDebut.getTime() === dateAujourdhui.getTime()) {
    this.toastService.show("Vous ne pouvez pas enregistrer une émission avec la date d'aujourd'hui.", 'warning');
    return;
  }
    const data = { ...this.newEmission };

    if (this.isEditMode && this.editId !== null) {
      this.emissionService.update(this.editId, data).subscribe(() => {
        this.loadEmissions();
        this.resetForm();
      });
    } else {
      this.emissionService.add(data).subscribe(() => {
        this.loadEmissions();
        this.resetForm();
      });
    }
  }

  modifier(emission: any) {
    this.isEditMode = true;
    this.editId = emission.id;
   this.newEmission = {
  type: emission.type,
  autreType: emission.autreType || '',
  dateDebut: emission.dateDebut,
  dateFin: emission.dateFin,
  employe: { matricule: emission.employe?.matricule || '' },
  statut: emission.statut || 'En attente'
};

    this.remplirNomEtZone();
  }

  annulerModification() {
    this.resetForm();
  }

  deleteEmission(id: number) {
    this.emissionService.delete(id).subscribe(() => {
      this.loadEmissions();
    });
  }

  changerStatut(id: number, statut: string) {
    this.emissionService.changerStatut(id, statut).subscribe(() => {
      this.loadEmissions();
    });
  }

  resetForm() {
   this.newEmission = {
  type: '',
  autreType: '',
  dateDebut: '',
  dateFin: '',
  employe: { matricule: '' },
  statut: 'En attente'
};

    this.nomEmploye = '';
    this.zoneEmploye = '';
    this.isEditMode = false;
    this.editId = null;
  }
}

