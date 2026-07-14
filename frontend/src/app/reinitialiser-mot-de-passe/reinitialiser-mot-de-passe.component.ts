import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { EmployeService } from '../services/employe.service';
import { Router, RouterLink, RouterModule, RouterOutlet } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-reinitialiser-mot-de-passe',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink, RouterModule, RouterOutlet],
  templateUrl: './reinitialiser-mot-de-passe.component.html',
  styleUrls: ['./reinitialiser-mot-de-passe.component.css']
})
export class ReinitialiserMotDePasseComponent {
  identifiant: string = '';
  nouveauMotDePasse: string = '';
  confirmationMotDePasse: string = '';
  message: string = '';
  erreur: string = '';
  showPassword: boolean = false;
  showConfirmPassword: boolean = false;

  passwordStrength: 'faible' | 'moyen' | 'fort' | '' = '';

  constructor(
    private employeService: EmployeService,
    private router: Router,
    private toastr: ToastrService
  ) {}

  getPasswordStrength(): void {
    const pwd = this.nouveauMotDePasse;
    if (!pwd) {
      this.passwordStrength = '';
    } else if (pwd.length < 6 || !/[A-Z]/.test(pwd) || !/\d/.test(pwd)) {
      this.passwordStrength = 'faible';
    } else if (pwd.length >= 6 && /[A-Z]/.test(pwd) && /\d/.test(pwd)) {
      this.passwordStrength = /[^A-Za-z0-9]/.test(pwd) ? 'fort' : 'moyen';
    }
  }

  changerMotDePasse(): void {
    if (!this.identifiant.trim() || !this.nouveauMotDePasse.trim() || !this.confirmationMotDePasse.trim()) {
      this.toastr.error('Veuillez remplir tous les champs.');
      this.erreur = 'Tous les champs sont requis.';
      return;
    }

    if (this.nouveauMotDePasse.length < 6) {
      this.toastr.error('Le mot de passe doit contenir au moins 6 caractères.');
      this.erreur = 'Mot de passe trop court.';
      return;
    }

    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$/;
    if (!regex.test(this.nouveauMotDePasse)) {
      this.toastr.error('Le mot de passe doit contenir une majuscule, une minuscule et un chiffre.');
      this.erreur = 'Mot de passe trop simple.';
      return;
    }

    if (this.nouveauMotDePasse !== this.confirmationMotDePasse) {
      this.toastr.error('Les mots de passe ne correspondent pas.');
      this.erreur = 'Les mots de passe ne correspondent pas.';
      return;
    }

    this.employeService.verifierIdentifiant(this.identifiant).subscribe({
      next: (existe: boolean) => {
        if (!existe) {
          this.toastr.error("Cet identifiant n'existe pas.");
          this.erreur = "Identifiant introuvable.";
          return;
        }

        this.employeService.changerMotDePasse(this.identifiant, this.nouveauMotDePasse).subscribe({
          next: (response) => {
            this.toastr.success(response.message);
            this.message = response.message;
            this.erreur = '';
            this.identifiant = '';
            this.nouveauMotDePasse = '';
            this.confirmationMotDePasse = '';
            this.passwordStrength = '';
            setTimeout(() => this.router.navigate(['/login']), 2000);
          },
          error: () => {
            this.toastr.error("Erreur lors de la réinitialisation.");
            this.erreur = "Erreur lors de la réinitialisation.";
          }
        });
      },
      error: () => {
        this.toastr.error("Erreur de communication avec le serveur.");
        this.erreur = "Erreur de communication avec le serveur.";
      }
    });
  }

}
