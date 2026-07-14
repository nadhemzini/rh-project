import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AnomalieServiceService {

  private apiUrl = `${environment.apiUrl}/anomalies`;

  constructor(private http: HttpClient) {}

  ajouter(anomalie: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, anomalie);
  }

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/all`);
  }

  changerStatut(id: number, statut: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}/changer-statut?statut=${statut}`, {});
  }

  supprimer(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }

  modifier(id: number, anomalie: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}/modifier`, anomalie);
  }
}
