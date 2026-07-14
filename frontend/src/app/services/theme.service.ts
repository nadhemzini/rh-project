import { Injectable, Inject, PLATFORM_ID } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ThemeService {
  private activeThemeSubject = new BehaviorSubject<'light' | 'dark'>('light');
  activeTheme$ = this.activeThemeSubject.asObservable();
  private isBrowser: boolean;

  constructor(@Inject(PLATFORM_ID) platformId: Object) {
    this.isBrowser = isPlatformBrowser(platformId);
    this.initTheme();
  }

  private initTheme(): void {
    if (!this.isBrowser) return;
    const savedTheme = localStorage.getItem('app-theme') as 'light' | 'dark';
    const initialTheme = savedTheme || 'light';
    this.setTheme(initialTheme);
  }

  setTheme(theme: 'light' | 'dark'): void {
    if (!this.isBrowser) return;
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('app-theme', theme);
    this.activeThemeSubject.next(theme);
  }

  toggleTheme(): void {
    const nextTheme = this.activeThemeSubject.value === 'light' ? 'dark' : 'light';
    this.setTheme(nextTheme);
  }

  getCurrentTheme(): 'light' | 'dark' {
    return this.activeThemeSubject.value;
  }
}
