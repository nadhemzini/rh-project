import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AnomaliePaieServiceService {

   private apiUrl = 'http://192.168.1.7:8081/api/anomalies-paie';

  constructor(private http: HttpClient) {}

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  add(anomalie: any): Observable<any> {
    return this.http.post(this.apiUrl, anomalie);
  }

  update(id: number, anomalie: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}`, anomalie);
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }
  changerStatut(id: number, statut: string): Observable<any> {
  // On envoie un PATCH ou PUT pour mettre à jour le statut
  return this.http.patch(`${this.apiUrl}/${id}/statut`, { statut });
}

}
