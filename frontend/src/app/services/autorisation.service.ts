import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AutorisationService {

 private apiUrl = `${environment.apiUrl}/autorisations`;

  constructor(private http: HttpClient) { }

  getAllAutorisations(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/afficher`);
  }

  addAutorisation(autorisation: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, autorisation);
  }

  updateAutorisation(id: number, autorisation: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/modifier/${id}`, autorisation);
  }

  deleteAutorisation(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/supprimer/${id}`);
  }
  changerStatutParRole(id: number, role: string, statut: string) {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const matricule = user.matricule || '';
    return this.http.put(`${this.apiUrl}/changer-statut/${id}?role=${role}&statut=${statut}&matricule=${matricule}`, {});
  }

  getTopAutorisations(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/top`);
  }

  changerStatutParRoleAvecMotif(id: number, role: string, statut: string, motifRefus: string) {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const matricule = user.matricule || '';
    return this.http.put(`${this.apiUrl}/changer-statut/${id}`, null, {
      params: { role, statut, motifRefus, matricule }
    });
  }




}
