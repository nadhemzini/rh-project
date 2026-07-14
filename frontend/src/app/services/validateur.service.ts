import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ValidateurService {

  private apiUrl = `${environment.apiUrl}/validateurs`;

  constructor(private http: HttpClient) { }

  getAllValidators(role: string): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/afficher?role=${role}`);
  }

  getEmployeesByZone(zone: string, role: string): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/employees-by-zone?zone=${zone}&role=${role}`);
  }

  changeValidator(oldValidatorId: number, newValidatorId: number, role: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/change?role=${role}`, {
      oldValidatorId,
      newValidatorId
    });
  }

  toggleValidatorStatus(id: number, active: boolean, role: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}/status?role=${role}`, { active });
  }
}
