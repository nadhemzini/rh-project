import { AuthServiceService } from './../services/auth-service.service';
import { Component } from '@angular/core';
import { EmployeService } from '../services/employe.service';
import { Router, RouterModule, RouterOutlet } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ThemeService } from '../services/theme.service';


@Component({
  selector: 'app-login',
  standalone: true,
  imports: [RouterOutlet,CommonModule,FormsModule,HttpClientModule,RouterModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {

matricule: string = '';
motdepasse: string = '';

  errorMessage = '';
showPassword: boolean = false;
currentTheme: 'light' | 'dark' = 'light';

togglePasswordVisibility() {
  this.showPassword = !this.showPassword;
}

toggleTheme() {
  this.themeService.toggleTheme();
}


  constructor(
    private employeService: EmployeService,
    private router: Router,
    private authService: AuthServiceService,
    private themeService: ThemeService
  ) {
    this.themeService.activeTheme$.subscribe(theme => {
      this.currentTheme = theme;
    });
  }



login() {
  this.employeService.login(this.matricule, this.motdepasse).subscribe({
    next: (response) => {
      localStorage.setItem('user', JSON.stringify(response));
      this.authService.setRole(
        response.role, 
        response.token, 
        response.zone, 
        response.fullname || response.nom || '', 
        response.matricule
      );
      this.router.navigate(['/dashboard']);
    },
    error: (error) => {
      this.errorMessage = error.status === 403
        ? 'Vous n\'avez pas les permissions pour accéder à l\'application.'
        : 'Matricule ou mot de passe incorrect !';
    }
  });
}



}





