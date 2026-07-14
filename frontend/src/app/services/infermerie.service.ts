import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class InfermerieService {

   private apiUrl = `${environment.apiUrl}/infermerie`;

  constructor(private http: HttpClient) {}

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/afficher`);
  }

  add(infermerie: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, infermerie);
  }

  update(id: number, infermerie: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/modifier/${id}`, infermerie);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/supprimer/${id}`);
  }

  changerStatut(id: number, statut: string): Observable<any> {
    return this.http.patch(`${this.apiUrl}/${id}/statut`, { statut });
  }
}
