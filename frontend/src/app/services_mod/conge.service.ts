import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CongeService {

 private apiUrl = 'http://192.168.1.7:8081/api/conges';

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
  const encodedRole = encodeURIComponent(role.trim());
  const encodedStatut = encodeURIComponent(statut.trim());
  return this.http.put(`${this.apiUrl}/changer-statut/${id}?role=${encodedRole}&statut=${encodedStatut}`, {});
}
changerStatutParRoleAvecMotif(id: number, role: string, statut: string, motifRefus: string) {
  const params = {
    role: role.trim(),
    statut: statut.trim(),
    motifRefus: motifRefus.trim()
  };
  return this.http.put(`${this.apiUrl}/changer-statut/${id}`, null, { params });
}

}
