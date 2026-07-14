import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DemandeDocumentService {

  private apiUrl = 'http://192.168.1.7:8081/api/demandes-documents';

  constructor(private http: HttpClient) {}

  ajouterDemande(demande: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, demande);
  }

  getDemandesParEmploye(matricule: string): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/employe/${matricule}`);
  }



  getAllDemandes(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/all`);  // Ajout du this.apiUrl ici pour cohérence
  }

  changerStatut(id: number, statut: string): Observable<any> {
    // appel PUT avec paramètres query string statut
    return this.http.put<any>(`${this.apiUrl}/${id}/changer-statut?statut=${statut}`, null);
  }
  modifierDemande(id: number, demande: any) {
    return this.http.put(`${this.apiUrl}/${id}/modifier`, demande);
  }

  supprimerDemande(id: number) {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }


}
