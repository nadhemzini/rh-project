import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CongeService {

 private apiUrl = `${environment.apiUrl}/conges`;

  constructor(private http: HttpClient) {}

  getAllConges(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/afficher`);
  }

  addConge(conge: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, conge);
  }

  updateConge(id: number, conge: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/modifier/${id}`, conge);
  }

  deleteConge(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/supprimer/${id}`);
  }
  changerStatutParRole(id: number, role: string, statut: string) {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const matricule = user.matricule || '';
    const encodedRole = encodeURIComponent(role.trim());
    const encodedStatut = encodeURIComponent(statut.trim());
    return this.http.put(`${this.apiUrl}/changer-statut/${id}?role=${encodedRole}&statut=${encodedStatut}&matricule=${matricule}`, {});
  }
  changerStatutParRoleAvecMotif(id: number, role: string, statut: string, motifRefus: string) {
    const user = JSON.parse(localStorage.getItem('user') || '{}');
    const matricule = user.matricule || '';
    const params = {
      role: role.trim(),
      statut: statut.trim(),
      motifRefus: motifRefus.trim(),
      matricule: matricule
    };
    return this.http.put(`${this.apiUrl}/changer-statut/${id}`, null, { params });
  }


}
