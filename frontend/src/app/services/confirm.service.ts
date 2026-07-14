import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

export interface ConfirmState {
  message: string;
  resolve: (value: boolean) => void;
}

@Injectable({
  providedIn: 'root'
})
export class ConfirmService {
  private confirmSubject = new BehaviorSubject<ConfirmState | null>(null);
  confirmState$ = this.confirmSubject.asObservable();

  confirm(message: string): Promise<boolean> {
    return new Promise<boolean>((resolve) => {
      this.confirmSubject.next({
        message,
        resolve: (val: boolean) => {
          this.confirmSubject.next(null);
          resolve(val);
        }
      });
    });
  }
}
