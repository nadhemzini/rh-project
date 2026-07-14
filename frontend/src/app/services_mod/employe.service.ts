import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class EmployeService {

private apiUrl = `${environment.apiUrl}/employes`;

  constructor(private http: HttpClient) { }

 login(matricule: string, password: string): Observable<any> {
  return this.http.post(`${this.apiUrl}/login`, {
    matricule: matricule,
    password: password
  });
}


  getEmployeByMatricule(matricule: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/matricule/${matricule}`);
  }



  getAllEmployes(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/afficher`);
  }

  addEmploye(employe: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, employe);
  }

  updateEmploye(id: number, employe: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/modifier/${id}`, employe);
  }

  deleteEmploye(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/supprimer/${id}`);
  }
 verifierIdentifiant(identifiant: string): Observable<boolean> {
    return this.http.get<boolean>(`${this.apiUrl}/verifier-identifiant?identifiant=${identifiant}`);
  }

changerMotDePasse(identifiant: string, nouveauMotDePasse: string): Observable<{message: string}> {
  return this.http.post<{message: string}>(`${this.apiUrl}/changer-mot-de-passe`, { identifiant, nouveauMotDePasse });
}





}
