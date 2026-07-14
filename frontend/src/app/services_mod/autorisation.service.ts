import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AutorisationService {

 private apiUrl = 'http://192.168.1.7:8081/api/autorisations';

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
    return this.http.put(`${this.apiUrl}/changer-statut/${id}?role=${role}&statut=${statut}`, {});
  }

getTopAutorisations(): Observable<any[]> {
  return this.http.get<any[]>(`${this.apiUrl}/top`);
}

changerStatutParRoleAvecMotif(id: number, role: string, statut: string, motifRefus: string) {
  return this.http.put(`${this.apiUrl}/changer-statut/${id}`, null, {
    params: { role, statut, motifRefus }
  });
}



}
