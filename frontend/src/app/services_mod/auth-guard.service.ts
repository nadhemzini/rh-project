import { isPlatformBrowser } from '@angular/common';
import { Inject, Injectable, PLATFORM_ID } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AuthGuardService implements CanActivate {

  constructor(private router: Router, @Inject(PLATFORM_ID) private platformId: Object) {}

  canActivate(route: ActivatedRouteSnapshot): boolean {
    if (isPlatformBrowser(this.platformId)) { // ✅ Vérifie si on est dans le navigateur
      const user = JSON.parse(localStorage.getItem('user')!);

      if (!user) {
        this.router.navigate(['/login']);
        return false;
      }

      const allowedRoles = route.data['roles'] as Array<string>;
      if (allowedRoles && !allowedRoles.includes(user.role)) {
        this.router.navigate(['/']);
        return false;
      }

      return true;
    }

    // Par défaut, ne pas autoriser sur le serveur
    return false;
  }
}

