import { Component, OnInit } from '@angular/core';
import { EmployeService } from '../services/employe.service';
import { RouterLink, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-employe',
  standalone: true,
  imports: [CommonModule,RouterModule,FormsModule],
  templateUrl: './employe.component.html',
  styleUrl: './employe.component.css'
})
export class EmployeComponent implements OnInit {

  employes: any[] = [];
  employeForm: any = {
    fullname: '',
    role: 'EMPLOYE',
    zone: '',
    motdepaase:'',
    matricule:''
  };
  isEditing = false;
  selectedEmployeId: number | null = null;

  searchMatricule: string = '';
searchNom: string = '';
searchZone: string = '';

employesOriginal: any[] = [];

currentPage: number = 1;
itemsPerPage: number = 10;
totalPages: number = 0;


  constructor(private employeService: EmployeService) { }

  ngOnInit(): void {
    this.getEmployes();
  }

getEmployes() {
  this.employeService.getAllEmployes().subscribe(data => {
    this.employes = data.reverse(); // Afficher les plus récents en haut
    this.employesOriginal = [...this.employes];
    this.calculerTotalPages();
  });
}
getEmployesPage() {
  const startIndex = (this.currentPage - 1) * this.itemsPerPage;
  return this.employes.slice(startIndex, startIndex + this.itemsPerPage);
}

calculerTotalPages() {
  this.totalPages = Math.ceil(this.employes.length / this.itemsPerPage);
}

previousPage() {
  if (this.currentPage > 1) {
    this.currentPage--;
  }
}

nextPage() {
  if (this.currentPage < this.totalPages) {
    this.currentPage++;
  }
}

goToPage(page: number) {
  this.currentPage = page;
}

getPages(): number[] {
  const pages: number[] = [];
  const maxVisible = 5;
  const halfVisible = Math.floor(maxVisible / 2);

  let startPage = Math.max(1, this.currentPage - halfVisible);
  let endPage = Math.min(this.totalPages, startPage + maxVisible - 1);

  // Adjust if we're near the end to always show maxVisible pages
  if (endPage - startPage < maxVisible - 1) {
    startPage = Math.max(1, endPage - maxVisible + 1);
  }

  for (let i = startPage; i <= endPage; i++) {
    pages.push(i);
  }

  return pages;
}
rechercherEmployes() {
  this.employes = this.employesOriginal.filter(employe => {
    const matchMatricule = this.searchMatricule ? employe.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase()) : true;
    const matchNom = this.searchNom ? employe.fullname?.toLowerCase().includes(this.searchNom.toLowerCase()) : true;
    const matchPoste = this.searchZone ? employe.zone?.toLowerCase().includes(this.searchZone.toLowerCase()) : true;

    return matchMatricule && matchNom && matchPoste;
  });

  this.currentPage = 1;
  this.calculerTotalPages();
}
resetRecherche() {
  this.searchMatricule = '';
  this.searchNom = '';
  this.searchZone = '';
  this.employes = [...this.employesOriginal];
  this.currentPage = 1;
  this.calculerTotalPages();
}

  ajouterEmploye() {
    this.employeService.addEmploye(this.employeForm).subscribe(() => {
      this.getEmployes();
      this.resetForm();
    });
  }

  modifierEmploye(employe: any) {
    this.isEditing = true;
    this.selectedEmployeId = employe.id;
    this.employeForm = { ...employe };
  }

  enregistrerModification() {
    if (this.selectedEmployeId != null) {
      this.employeService.updateEmploye(this.selectedEmployeId, this.employeForm).subscribe(() => {
        this.getEmployes();
        this.resetForm();
        this.isEditing = false;
        this.selectedEmployeId = null;
      });
    }
  }

  supprimerEmploye(id: number) {
    this.employeService.deleteEmploye(id).subscribe(() => {
      this.getEmployes();
    });
  }

  resetForm() {
    this.employeForm = {
      fullname: '',
      role: 'EMPLOYE',
      zone: '',
      matricule:'',
      motdepasse: '',
    };
  }
}
