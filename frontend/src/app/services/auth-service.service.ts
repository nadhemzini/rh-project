import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthServiceService {

  private userRoleSubject = new BehaviorSubject<string>(this.getRoleFromStorage());
  userRole$ = this.userRoleSubject.asObservable();
  private userZoneSubject = new BehaviorSubject<string>(this.getZoneFromStorage());
  private userFullnameSubject = new BehaviorSubject<string>(this.getFullnameFromStorage());
  userFullname$ = this.userFullnameSubject.asObservable();
  private userMatriculeSubject = new BehaviorSubject<string>(this.getMatriculeFromStorage());
  userMatricule$ = this.userMatriculeSubject.asObservable();

  userZone$ = this.userZoneSubject.asObservable();

  constructor() {
    console.log('Role initial dans AuthServiceService:', this.getRoleFromStorage());
  }

  setRole(role: string, token: string, zone: string, fullname: string, matricule?: string) {
    localStorage.setItem('user', JSON.stringify({ role, token, zone, fullname, matricule }));
    this.userRoleSubject.next(role);
    this.userZoneSubject.next(zone);
    this.userFullnameSubject.next(fullname);
    if (matricule) {
      this.userMatriculeSubject.next(matricule);
    }
  }

  setZone(zone: string) {
    localStorage.setItem('userZone', zone); // ✅ on stocke la zone dans localStorage
    this.userZoneSubject.next(zone);
  }

  getRoleFromStorage(): string {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return user.role || '';
    } catch (e) {
      return '';
    }
  }

  getZoneFromStorage(): string {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return user.zone || '';
    } catch (e) {
      return '';
    }
  }

  getMatriculeFromStorage(): string {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return user.matricule || '';
    } catch (e) {
      return '';
    }
  }

  getToken(): string {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return user.token || '';
    } catch (e) {
      return '';
    }
  }

  clearRole() {
    localStorage.removeItem('user');
    this.userRoleSubject.next('');
  }

  logout() {
    localStorage.removeItem('user');
    this.userRoleSubject.next('');
    this.userZoneSubject.next('');
    this.userFullnameSubject.next('');
    this.userMatriculeSubject.next('');
  }

  getZonesList(): string[] {
    const zone = this.getZoneFromStorage();
    return zone ? zone.split('/').map(z => z.trim()) : [];
  }

  getFullnameFromStorage(): string {
    try {
      const user = JSON.parse(localStorage.getItem('user') || '{}');
      return user.fullname || '';
    } catch (e) {
      return '';
    }
  }

}

