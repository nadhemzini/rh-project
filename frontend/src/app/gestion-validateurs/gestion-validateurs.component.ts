import { Component, OnInit } from '@angular/core';
import { ValidateurService } from '../services/validateur.service';
import { AuthServiceService } from '../services/auth-service.service';
import { ToastService } from '../services/toast.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-gestion-validateurs',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './gestion-validateurs.component.html',
  styleUrl: './gestion-validateurs.component.css'
})
export class GestionValidateursComponent implements OnInit {
  validators: any[] = [];
  validatorsOriginal: any[] = [];
  userRole = '';
  
  searchName: string = '';
  searchMatricule: string = '';
  searchZone: string = '';
  filterStatus: string = '';
  
  currentPage: number = 1;
  itemsPerPage: number = 20;
  totalPages: number = 0;
  
  // Modal state
  showModal: boolean = false;
  selectedValidator: any = null;
  availableEmployees: any[] = [];
  selectedNewValidatorId: number | null = null;
  loading: boolean = false;
  changingValidator: boolean = false;
  
  constructor(
    private validateurService: ValidateurService,
    private authService: AuthServiceService,
    private toastService: ToastService
  ) {}
  
  ngOnInit() {
    this.authService.userRole$.subscribe(role => {
      this.userRole = role;
    });
    this.loadValidators();
  }
  
  loadValidators() {
    this.loading = true;
    this.validateurService.getAllValidators(this.userRole).subscribe({
      next: (data) => {
        this.validators = data;
        this.validatorsOriginal = [...data];
        this.calculerTotalPages();
        this.loading = false;
      },
      error: (err) => {
        this.toastService.show('Erreur lors du chargement des validateurs', 'error');
        this.loading = false;
      }
    });
  }
  
  getValidatorsPage() {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    return this.validators.slice(startIndex, startIndex + this.itemsPerPage);
  }
  
  calculerTotalPages() {
    this.totalPages = Math.ceil(this.validators.length / this.itemsPerPage);
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
  
  rechercherValidators() {
    this.validators = this.validatorsOriginal.filter(validator => {
      const matchName = this.searchName ? validator.fullname?.toLowerCase().includes(this.searchName.toLowerCase()) : true;
      const matchMatricule = this.searchMatricule ? validator.matricule?.toLowerCase().includes(this.searchMatricule.toLowerCase()) : true;
      const matchZone = this.searchZone ? validator.zone?.toLowerCase().includes(this.searchZone.toLowerCase()) : true;
      const matchStatus = this.filterStatus ? 
        (this.filterStatus === 'active' ? validator.active : !validator.active) : true;
      
      return matchName && matchMatricule && matchZone && matchStatus;
    });
    
    this.currentPage = 1;
    this.calculerTotalPages();
  }
  
  resetRecherche() {
    this.searchName = '';
    this.searchMatricule = '';
    this.searchZone = '';
    this.filterStatus = '';
    this.validators = [...this.validatorsOriginal];
    this.currentPage = 1;
    this.calculerTotalPages();
  }
  
  openChangeModal(validator: any) {
    this.selectedValidator = validator;
    this.showModal = true;
    this.selectedNewValidatorId = null;
    this.availableEmployees = [];
    
    // Disable body scroll when modal opens
    document.body.style.overflow = 'hidden';
    
    // Load employees from the same zone
    this.validateurService.getEmployeesByZone(validator.zone, this.userRole).subscribe({
      next: (data) => {
        this.availableEmployees = data.filter(emp => emp.id !== validator.id);
      },
      error: (err) => {
        this.toastService.show('Erreur lors du chargement des employés', 'error');
      }
    });
  }
  
  closeModal() {
    this.showModal = false;
    this.selectedValidator = null;
    this.selectedNewValidatorId = null;
    this.availableEmployees = [];
    
    // Re-enable body scroll when modal closes
    document.body.style.overflow = '';
  }
  
  confirmChangeValidator() {
    if (!this.selectedNewValidatorId) {
      this.toastService.show('Veuillez sélectionner un nouveau validateur', 'warning');
      return;
    }
    
    this.changingValidator = true;
    this.validateurService.changeValidator(
      this.selectedValidator.id,
      this.selectedNewValidatorId,
      this.userRole
    ).subscribe({
      next: (response) => {
        this.toastService.show('Validateur modifié avec succès', 'success');
        this.closeModal();
        this.loadValidators();
        this.changingValidator = false;
      },
      error: (err) => {
        this.toastService.show(err.error || 'Erreur lors de la modification du validateur', 'error');
        this.changingValidator = false;
      }
    });
  }
  
  toggleStatus(validator: any) {
    const newStatus = !validator.active;
    const action = newStatus ? 'activation' : 'désactivation';
    
    this.validateurService.toggleValidatorStatus(validator.id, newStatus, this.userRole).subscribe({
      next: (response) => {
        validator.active = newStatus;
        this.toastService.show(`Validateur ${newStatus ? 'activé' : 'désactivé'} avec succès`, 'success');
      },
      error: (err) => {
        this.toastService.show(`Erreur lors de l'${action} du validateur`, 'error');
      }
    });
  }
  
  getStatusBadge(active: boolean) {
    return active ? 'Actif' : 'Désactivé';
  }
  
  getStatusClass(active: boolean) {
    return active ? 'badge-success' : 'badge-danger';
  }

  getRoleBadgeClass(role: string) {
    if (role === 'Sécurité') {
      return 'bg-warning text-dark';
    }
    return 'bg-primary text-white';
  }
}
