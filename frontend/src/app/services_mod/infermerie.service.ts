import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class InfermerieService {

   private apiUrl = 'http://192.168.1.7:8081/api/infermerie';

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
