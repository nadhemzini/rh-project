import { Component, OnInit } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { AuthServiceService } from '../services/auth-service.service';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { EmployeService } from '../services/employe.service';
import { CongeService } from '../services/conge.service';
import { AutorisationService } from '../services/autorisation.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [RouterModule, ReactiveFormsModule, FormsModule, CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent implements OnInit {
  userRole = '';
  totalEmployes = 0;
  totalConges = 0;
  totalAutorisations = 0;
  topAutorisationsParZone: { zone: string; employe: any }[] = [];
  zoneCongesParMois: { zone: string, count: number }[] = [];
  topEmployesParZone: { zone: string; employe: any }[] = [];
  totalCongesMois = 0;
  totalAutorisationsMois = 0;

  congesAcceptes = 0;
  congesRefuses = 0;
  congesEnAttente = 0;
  zoneAutorisationsParMois: { zone: string, count: number }[] = [];
  topEmployesSortBy: 'nbConges' | 'totalJoursConge' = 'nbConges';
  allConges: any[] = [];

  congesAcceptesMois = 0;
  congesRefusesMois = 0;
  congesEnAttenteMois = 0;

  topEmployes: any[] = [];
  currentYear: number = new Date().getFullYear();

  selectedMonth: number = new Date().getMonth() + 1;
  selectedYear: number = new Date().getFullYear();
  moisList = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
  anneesList: number[] = [];
  statsLoaded = false;

  constructor(
    private authService: AuthServiceService,
    private router: Router,
    private employeService: EmployeService,
    private congeService: CongeService,
    private autorisationService: AutorisationService
  ) {}

  ngOnInit() {
    this.authService.userRole$.subscribe(role => {
      this.userRole = role;
      console.log('Rôle dans dashboard:', role);
    });

    this.loadStatistics();
    this.loadAllConges();
    this.loadAllAutorisations();
    this.calculateTopEmployesParZone();
    this.calculateTopAutorisationsParZone();
  }

  loadStatistics() {
    this.employeService.getAllEmployes().subscribe(data => {
      this.totalEmployes = data.length;
    });

    this.congeService.getAllConges().subscribe(data => {
      this.totalConges = data.length;
      this.congesAcceptes = data.filter(c => c.statut === 'Accepté').length;
      this.congesRefuses = data.filter(c => c.statut === 'Refusé').length;
      this.congesEnAttente = data.filter(c => c.statut === 'En attente').length;

      this.calculateTopEmployes(data);
    });

    this.autorisationService.getAllAutorisations().subscribe(data => {
      this.totalAutorisations = data.length;
    });
  }

  loadAllConges() {
    this.congeService.getAllConges().subscribe(data => {
      this.allConges = data;
      this.generateAnneesList();
      this.calculateTopEmployesParZone();
      this.loadMonthlyStatistics();
    });
  }

  generateAnneesList() {
    const startYear = 1900;
    const endYear = new Date().getFullYear() + 40;
    this.anneesList = [];

    for (let year = startYear; year <= endYear; year++) {
      this.anneesList.push(year);
    }
  }

  loadMonthlyStatistics() {
    const selectedYearNum = Number(this.selectedYear);
    const selectedMonthNum = Number(this.selectedMonth);

    const filteredConges = this.allConges.filter(conge => {
      if (!conge.dateDebut) return false;
      const congeDate = new Date(conge.dateDebut);
      if (isNaN(congeDate.getTime())) return false;
      return congeDate.getFullYear() === selectedYearNum && (congeDate.getMonth() + 1) === selectedMonthNum;
    });

    this.totalCongesMois = filteredConges.length;
    this.congesAcceptesMois = filteredConges.filter(c => c.statut?.trim().toLowerCase() === 'accepté').length;
    this.congesRefusesMois = filteredConges.filter(c => c.statut?.trim().toLowerCase() === 'refusé').length;
    this.congesEnAttenteMois = filteredConges.filter(c => c.statut?.trim().toLowerCase() === 'en attente').length;

    const congesAcceptes = filteredConges.filter(c => c.statut?.trim().toLowerCase() === 'accepté');
    const zoneCountMap = new Map<string, number>();

    congesAcceptes.forEach(c => {
      const zone = c.employe?.zone?.trim() || 'Non défini';
      zoneCountMap.set(zone, (zoneCountMap.get(zone) || 0) + 1);
    });

    this.zoneCongesParMois = Array.from(zoneCountMap.entries()).map(([zone, count]) => ({ zone, count }));
    this.zoneCongesParMois.sort((a, b) => b.count - a.count);
    this.statsLoaded = true;
  }

  calculateTopEmployes(conges: any[]) {
    const employeMap = new Map();

    conges
      .filter(conge => conge.statut === 'Accepté')
      .forEach(conge => {
        const key = conge.employe.matricule;
        const dateDebut = new Date(conge.dateDebut);
        const dateFin = new Date(conge.dateFin);
        const diffTime = dateFin.getTime() - dateDebut.getTime();
        const joursConge = Math.ceil(diffTime / (1000 * 3600 * 24)) + 1;

        if (employeMap.has(key)) {
          const emp = employeMap.get(key);
          emp.nbConges++;
          emp.totalJoursConge += joursConge;
        } else {
          employeMap.set(key, {
            fullname: conge.employe.fullname,
            matricule: conge.employe.matricule,
            zone: conge.employe.zone,
            nbConges: 1,
            totalJoursConge: joursConge
          });
        }
      });

    this.topEmployes = Array.from(employeMap.values())
      .sort((a, b) => b.totalJoursConge - a.totalJoursConge)
      .slice(0, 5);
  }

  logout() {
    this.authService.logout();
    this.router.navigate(['/login']);
  }

  selectedMonthAut: number = new Date().getMonth() + 1;
  selectedYearAut: number = new Date().getFullYear();

  allAutorisations: any[] = [];

  autorisationsAcceptesMois = 0;
  autorisationsRefuseesMois = 0;
  autorisationsEnAttenteMois = 0;

  statsAutorisationsLoaded = false;

  loadAllAutorisations() {
    this.autorisationService.getAllAutorisations().subscribe((data) => {
      this.allAutorisations = data.reverse(); // ✅ plus de filtre par rôle
      this.loadMonthlyAutorisationsStats();
      this.calculateTopAutorisationsParZone();
    });
  }

  loadMonthlyAutorisationsStats() {
    const selectedYearNum = Number(this.selectedYearAut);
    const selectedMonthNum = Number(this.selectedMonthAut);

    const filtered = this.allAutorisations.filter(aut => {
      if (!aut.date) return false;
      const autDate = new Date(aut.date);
      return autDate.getFullYear() === selectedYearNum && (autDate.getMonth() + 1) === selectedMonthNum;
    });

    this.totalAutorisationsMois = filtered.length;
    this.autorisationsAcceptesMois = filtered.filter(a => a.statut?.trim().toLowerCase() === 'accepté').length;
    this.autorisationsRefuseesMois = filtered.filter(a => a.statut?.trim().toLowerCase() === 'refusé').length;
    this.autorisationsEnAttenteMois = filtered.filter(a => a.statut?.trim().toLowerCase() === 'en attente').length;

    const autorisationsAcceptes = filtered.filter(a => a.statut?.trim().toLowerCase() === 'accepté');
    const zoneCountMap = new Map<string, number>();

    autorisationsAcceptes.forEach(a => {
      const zone = a.employe?.zone?.trim() || 'Non défini';
      zoneCountMap.set(zone, (zoneCountMap.get(zone) || 0) + 1);
    });

    this.zoneAutorisationsParMois = Array.from(zoneCountMap.entries()).map(([zone, count]) => ({ zone, count }));
    this.zoneAutorisationsParMois.sort((a, b) => b.count - a.count);
    this.statsAutorisationsLoaded = true;
  }

  calculateTopEmployesParZone() {
  const year = Number(this.selectedYear);
  const month = Number(this.selectedMonth);

  const employeMap = new Map<string, {
    matricule: string,
    fullname: string,
    nbConges: number,
    totalJoursConge: number,
    zone: string
  }>();

  this.allConges
    .filter(c => {
      if (c.statut?.toLowerCase() !== 'accepté') return false;
      const d = new Date(c.dateDebut);
      return d.getFullYear() === year && (d.getMonth() + 1) === month;
    })
    .forEach(c => {
      const zone = c.employe?.zone?.trim() || 'Non défini';
      const matricule = c.employe?.matricule;
      const fullname = c.employe?.fullname;
      const dateDebut = new Date(c.dateDebut);
      const dateFin = new Date(c.dateFin);
      const joursConge = Math.ceil((dateFin.getTime() - dateDebut.getTime()) / (1000 * 3600 * 24)) + 1;
      const key = zone + '_' + matricule;

      if (employeMap.has(key)) {
        const emp = employeMap.get(key)!;
        emp.nbConges++;
        emp.totalJoursConge += joursConge;
      } else {
        employeMap.set(key, {
          matricule,
          fullname,
          zone,
          nbConges: 1,
          totalJoursConge: joursConge
        });
      }
    });

  const groupByZone = new Map<string, any[]>();
  employeMap.forEach(emp => {
    if (!groupByZone.has(emp.zone)) groupByZone.set(emp.zone, []);
    groupByZone.get(emp.zone)?.push(emp);
  });

  const newTop: { zone: string; employe: any }[] = [];

  groupByZone.forEach((employes, zone) => {
    // Trier les employés selon le critère choisi
    employes.sort((a, b) => b[this.topEmployesSortBy] - a[this.topEmployesSortBy]);

    // Récupérer la valeur du top employé
    const topValue = employes[0][this.topEmployesSortBy];

    // Filtrer tous ceux qui ont exactement la même valeur
    const topEmployes = employes.filter(emp => emp[this.topEmployesSortBy] === topValue);

    // Ajouter les ex aequo, sinon un seul
    topEmployes.forEach(emp => {
      newTop.push({ zone, employe: emp });
    });
  });

  this.topEmployesParZone = newTop;
}


  onMonthYearChange() {
    this.calculateTopEmployesParZone();
  }

 calculateTopAutorisationsParZone() {
  const year = Number(this.selectedYearAut);
  const month = Number(this.selectedMonthAut);

  const zoneMap = new Map<string, {
    matricule: string,
    fullname: string,
    nbAutorisations: number,
    zone: string
  }>();

  // Étape 1 : Regrouper les autorisations acceptées par employé
  this.allAutorisations
    .filter(a => {
      if (a.statut?.toLowerCase() !== 'accepté') return false;
      const date = new Date(a.date);
      return date.getFullYear() === year && (date.getMonth() + 1) === month;
    })
    .forEach(a => {
      const zone = a.employe?.zone?.trim();
      const matricule = a.employe?.matricule;
      const fullname = a.employe?.fullname;
      if (!zone || !matricule || !fullname) return;

      const key = zone + '_' + matricule;
      if (zoneMap.has(key)) {
        zoneMap.get(key)!.nbAutorisations++;
      } else {
        zoneMap.set(key, { zone, matricule, fullname, nbAutorisations: 1 });
      }
    });

  // Étape 2 : Grouper par zone
  const groupByZone = new Map<string, any[]>();
  zoneMap.forEach(emp => {
    if (!groupByZone.has(emp.zone)) groupByZone.set(emp.zone, []);
    groupByZone.get(emp.zone)?.push(emp);
  });

  // Étape 3 : Pour chaque zone, ne garder que le(s) top employé(s)
  this.topAutorisationsParZone = [];
  groupByZone.forEach((employes, zone) => {
    employes.sort((a, b) => b.nbAutorisations - a.nbAutorisations);
    const topValue = employes[0].nbAutorisations;
    const topList = employes.filter(e => e.nbAutorisations === topValue);
    topList.forEach(emp => {
      this.topAutorisationsParZone.push({ zone, employe: emp });
    });
  });
}
isRestrictedRole(): boolean {
  return this.userRole === 'GARDIEN' || this.userRole === 'Chef d\'equipe'||this.userRole==='Agent de qualite';
}

}
