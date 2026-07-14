import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class InterrogatoireService {

   private apiUrl = `${environment.apiUrl}/interrogatoires`;


  constructor(private http: HttpClient) {}

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/afficher`);
  }

  getById(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }

  add(interrogatoire: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ajouter`, interrogatoire);
  }

  update(id: number, interrogatoire: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/modifier/${id}`, interrogatoire);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/supprimer/${id}`);
  }
}
