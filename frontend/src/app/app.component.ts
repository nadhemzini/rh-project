import { Component, OnInit } from '@angular/core';
import { Router, RouterModule, RouterOutlet, NavigationEnd } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AuthServiceService } from './services/auth-service.service';
import { ToastService, Toast } from './services/toast.service';
import { ConfirmService, ConfirmState } from './services/confirm.service';
import { ThemeService } from './services/theme.service';
import { filter } from 'rxjs/operators';

// Routes that should NEVER show the sidebar / dashboard layout
const GUEST_ROUTES = ['/login', '/reinitialiser-mot-de-passe'];

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CommonModule, FormsModule, HttpClientModule, RouterModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
  title = 'rh-app';
  isConnected = false;
  isGuestRoute = true;   // start as guest until we know the route
  userRole = '';
  userFullname = '';
  userZone = '';
  sidebarActive = false;
  currentTheme: 'light' | 'dark' = 'light';

  toasts: Toast[] = [];
  confirmState: ConfirmState | null = null;

  constructor(
    private router: Router,
    private authService: AuthServiceService,
    private toastService: ToastService,
    private confirmService: ConfirmService,
    private themeService: ThemeService
  ) {}


  ngOnInit() {
    // Detect guest routes via router events
    this.router.events
      .pipe(filter(e => e instanceof NavigationEnd))
      .subscribe((e: any) => {
        const url: string = e.urlAfterRedirects || e.url || '';
        this.isGuestRoute = GUEST_ROUTES.some(r => url.startsWith(r));
        // Close mobile sidebar on navigation
        this.sidebarActive = false;
      });

    // Check current URL immediately (in case already loaded)
    const currentUrl = this.router.url || '';
    this.isGuestRoute = GUEST_ROUTES.some(r => currentUrl.startsWith(r));

    // Subscribe to auth state
    this.authService.userRole$.subscribe(role => {
      this.userRole = role;
      this.isConnected = !!role;
    });

    this.authService.userFullname$.subscribe(fullname => {
      this.userFullname = fullname;
    });

    this.authService.userZone$.subscribe(zone => {
      this.userZone = zone;
    });

    this.themeService.activeTheme$.subscribe(theme => {
      this.currentTheme = theme;
    });

    this.toastService.toasts$.subscribe(toasts => {
      this.toasts = toasts;
    });

    this.confirmService.confirmState$.subscribe(state => {
      this.confirmState = state;
    });
  }

  get showDashboardLayout(): boolean {
    return this.isConnected && !this.isGuestRoute;
  }

  getInitials(): string {
    if (!this.userFullname) return 'U';
    return this.userFullname
      .split(' ')
      .map(n => n[0])
      .join('')
      .substring(0, 2)
      .toUpperCase();
  }

  toggleSidebar() {
    this.sidebarActive = !this.sidebarActive;
  }

  toggleTheme() {
    this.themeService.toggleTheme();
  }

  logout() {
    this.authService.logout();
    this.isConnected = false;
    this.sidebarActive = false;
    this.isGuestRoute = true;
    this.router.navigate(['/login']);
  }
}
