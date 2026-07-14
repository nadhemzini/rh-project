import { Component, OnInit } from '@angular/core';
import { AnomaliePaieServiceService } from '../services/anomalie-paie-service.service';
import { EmployeService } from '../services/employe.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';
import { AuthServiceService } from '../services/auth-service.service';

@Component({
  selector: 'app-anomalie-paie',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './anomalie-paie.component.html',
  styleUrls: ['./anomalie-paie.component.css']
})
export class AnomaliePaieComponent implements OnInit {
userRole: string = '';
  anomalies: any[] = [];
  employes: any[] = [];
  nomEmploye: string = '';
  zoneEmploye: string = '';
 isEditMode = false;
  editId: number | null = null;
searchMatricule: string = '';
searchZone: string = '';
searchTypeAnomalie: string = '';
searchStatut: string = '';
anomaliesAffichees: any[] = [];

  newAnomalie = {
    description: '',
    dateAnomalie: '',
    typeAnomalie: '',
    autreType: '',
    employe: {
      matricule: ''
    }
  };
currentPage: number = 1;
itemsPerPage: number = 10;
totalPages: number = 0;
anomaliesFiltrees: any[] = [];

moisList: string[] = [
  'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
  'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
];

searchMois: number | null = null;
searchAnnee: number | null = null;


  constructor(
    private anomalieService: AnomaliePaieServiceService,
    private employeService: EmployeService,
    private authService : AuthServiceService
  ) {}

  ngOnInit(): void {
    this.loadAnomalies();
    this.loadEmployes();
    this.userRole = this.authService.getRoleFromStorage()?.trim().toLowerCase() || '';

  }


loadAnomalies() {
  const userRole = this.authService.getRoleFromStorage()?.trim().toLowerCase();
  const zonesUtilisateur = this.authService.getZonesList().map(z => z.trim().toLowerCase());

  this.anomalieService.getAll().subscribe(data => {
    let filteredData;

    if (userRole === 'responsable rh' || userRole === 'chef securite' || userRole === 'sécurité') {
      // RH, Chef sécurité et Sécurité voient tout
      filteredData = data;

    } else if (userRole === 'directeur') {
      // Directeur : voir 'administration' et ses sous-zones
      filteredData = data.filter(a => {
        const zone = (a.employe?.zone || '').trim().toLowerCase().replace(/\s*\/\s*/g, '/');
        return zone === 'administration' || zone.startsWith('administration/');
      });

    } else {
      // Autres rôles : uniquement leurs zones
      filteredData = data.filter(a => {
        const zoneEmploye = (a.employe?.zone || '').trim().toLowerCase();
        return zonesUtilisateur.includes(zoneEmploye);
      });
    }

  this.anomalies = filteredData.reverse();
this.anomaliesFiltrees = [...this.anomalies];
this.totalPages = Math.ceil(this.anomaliesFiltrees.length / this.itemsPerPage);
this.currentPage = 1;
this.mettreAJourAnomaliesAffichees();
  });
}




  loadEmployes() {
    this.employeService.getAllEmployes().subscribe(data => {
      this.employes = data;
    });
  }

 addAnomalie() {
    const anomalieAEnvoyer = { ...this.newAnomalie };

    if (anomalieAEnvoyer.typeAnomalie === 'Autre') {
      anomalieAEnvoyer.typeAnomalie = anomalieAEnvoyer.autreType || 'Autre';
    }

    if (this.isEditMode && this.editId !== null) {
      // Appeler update au lieu de add
      this.anomalieService.update(this.editId, anomalieAEnvoyer).subscribe(() => {
        this.loadAnomalies();
        this.resetForm();
      });
    } else {
      this.anomalieService.add(anomalieAEnvoyer).subscribe(() => {
        this.loadAnomalies();
        this.resetForm();
      });
    }
  }

  resetForm() {
    this.newAnomalie = {
      description: '',
      dateAnomalie: '',
      typeAnomalie: '',
      autreType: '',
      employe: { matricule: '' }
    };
    this.nomEmploye = '';
    this.zoneEmploye = '';
    this.isEditMode = false;
    this.editId = null;
  }

  modifier(anomalie: any) {
    this.isEditMode = true;
    this.editId = anomalie.id;

    this.newAnomalie = {
      description: anomalie.description,
      dateAnomalie: anomalie.dateAnomalie,
      typeAnomalie: anomalie.typeAnomalie,
      autreType: anomalie.typeAnomalie === 'Autre' ? anomalie.autreType || '' : '',
      employe: { matricule: anomalie.employe?.matricule || '' }
    };

    // remplir nom et zone correspondants
    this.remplirNomEtZone();
  }

  annulerModification() {
    this.resetForm();
  }

  deleteAnomalie(id: number) {
    this.anomalieService.delete(id).subscribe(() => {
      this.loadAnomalies();
    });
  }

  remplirNomEtZone() {
    const matriculeSaisi = this.newAnomalie.employe.matricule;
    const emp = this.employes.find(e => e.matricule === matriculeSaisi);

    if (emp) {
      this.nomEmploye = emp.fullname;
      this.zoneEmploye = emp.zone;
      this.newAnomalie.employe = emp; // envoie l'objet complet
    } else {
      this.nomEmploye = '';
      this.zoneEmploye = '';
      this.newAnomalie.employe = { matricule: '' };
    }
  }

  changerStatut(id: number, statut: string) {
    this.anomalieService.changerStatut(id, statut).subscribe(() => this.loadAnomalies());
  }
 filtrerEtAfficherAnomalies() {
  let filtered = this.anomalies;

  if (this.searchMatricule.trim()) {
    filtered = filtered.filter(a =>
      a.employe?.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase())
    );
  }

  if (this.searchZone.trim()) {
    filtered = filtered.filter(a =>
      a.employe?.zone?.toLowerCase().includes(this.searchZone.toLowerCase())
    );
  }

  if (this.searchTypeAnomalie.trim()) {
    filtered = filtered.filter(a =>
      a.typeAnomalie === this.searchTypeAnomalie
    );
  }

  if (this.searchStatut.trim()) {
    filtered = filtered.filter(a =>
      a.statut === this.searchStatut
    );
  }

  this.anomaliesFiltrees = filtered;
  this.totalPages = Math.ceil(this.anomaliesFiltrees.length / this.itemsPerPage);
  this.currentPage = 1;
  this.mettreAJourAnomaliesAffichees();
}
mettreAJourAnomaliesAffichees() {
  const startIndex = (this.currentPage - 1) * this.itemsPerPage;
  const endIndex = startIndex + this.itemsPerPage;
  this.anomaliesAffichees = this.anomaliesFiltrees.slice(startIndex, endIndex);
}
changerPage(page: number) {
  if (page >= 1 && page <= this.totalPages) {
    this.currentPage = page;
    this.mettreAJourAnomaliesAffichees();
  }
}

resetRecherche() {
  this.searchMatricule = '';
  this.searchZone = '';
  this.searchTypeAnomalie = '';
  this.searchStatut = '';
  this.anomaliesAffichees = [...this.anomalies];
}
generatePdf() {
  const doc = new jsPDF();

  doc.setFontSize(16);
  doc.text('Liste des Anomalies de Paie', 14, 15);

  const columns: { header: string, dataKey: keyof AnomalieRow }[] = [
    { header: 'Matricule', dataKey: 'matricule' },
    { header: 'Nom', dataKey: 'nom' },
    { header: 'Zone', dataKey: 'zone' },
    { header: 'Type', dataKey: 'typeAnomalie' },
    { header: 'Description', dataKey: 'description' },
    { header: 'Date', dataKey: 'date' },
    { header: 'Statut', dataKey: 'statut' },
  ];

  type AnomalieRow = {
    matricule: string;
    nom: string;
    zone: string;
    typeAnomalie: string;
    description: string;
    date: string;
    statut: string;
  };

  const rows: AnomalieRow[] = this.anomaliesAffichees.map(a => ({
    matricule: a.employe?.matricule || '',
    nom: a.employe?.fullname || '',
    zone: a.employe?.zone || '',
    typeAnomalie: a.typeAnomalie || '',
    description: a.description || '',
    date: a.dateAnomalie || '',
    statut: a.statut || ''
  }));

  autoTable(doc, {
    head: [columns.map(col => col.header)],
    body: rows.map(row => columns.map(col => row[col.dataKey])),
    startY: 20,
    styles: { fontSize: 9 },
    headStyles: { fillColor: [30, 30, 30] },
  });

  doc.save('anomalies_paie.pdf');
}
generatePdfPers(anomalie: any) {
  const doc = new jsPDF();

  const employe = anomalie.employe || {};
  const nom = employe.fullname || 'Inconnu';
  const matricule = employe.matricule || '---';
  const zone = employe.zone || '---';

  doc.setFontSize(14);
  doc.text(`Fiche Anomalie de Paie`, 14, 15);

  doc.setFontSize(11);
  doc.text(`Nom complet : ${nom}`, 14, 25);
  doc.text(`Matricule   : ${matricule}`, 14, 32);
  doc.text(`Zone        : ${zone}`, 14, 39);

  autoTable(doc, {
    startY: 50,
    head: [['Type Anomalie', 'Description', 'Date', 'Statut']],
    body: [[
      anomalie.typeAnomalie || '',
      anomalie.description || '',
      anomalie.dateAnomalie || '',
      anomalie.statut || ''
    ]],
    styles: { fontSize: 10 },
    headStyles: { fillColor: [52, 73, 94] },
  });

  const fileName = `anomalie_${matricule}_${anomalie.id || Date.now()}.pdf`;
  doc.save(fileName);
}


}
