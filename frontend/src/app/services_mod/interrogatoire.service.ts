import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class InterrogatoireService {

   private apiUrl = 'http://192.168.1.7:8081/api/interrogatoires';


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
