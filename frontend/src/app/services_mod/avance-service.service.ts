import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AvanceServiceService {

  private apiUrl = 'http://192.168.1.7:8081/api/avances';

  constructor(private http: HttpClient) {}

  ajouterAvance(demande: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, demande);
  }

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/all`);
  }

  changerStatut(id: number, statut: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}/changer-statut?statut=${statut}`, {});
  }
modifier(id: number, demande: any): Observable<any> {
  return this.http.put(`${this.apiUrl}/${id}/modifier`, demande);
}

  supprimer(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }
}
