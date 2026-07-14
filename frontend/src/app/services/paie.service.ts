import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class PaieService {

  private apiUrl = `${environment.apiUrl}/paies`;

  constructor(private http: HttpClient) { }

  getAllPaies(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/afficher`);
  }

  addPaie(paie: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, paie);
  }

  updatePaie(id: number, paie: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/modifier/${id}`, paie);
  }

  deletePaie(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/supprimer/${id}`);
  }

  getTotalMensuel(mois: string): Observable<number> {
    return this.http.get<number>(`${this.apiUrl}/total/mensuel?mois=${mois}`);
  }

  getTotalAnnuel(): Observable<number> {
    return this.http.get<number>(`${this.apiUrl}/total/annuel`);
  }
}
