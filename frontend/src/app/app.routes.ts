import { Routes } from '@angular/router';

import { DashboardComponent } from './dashboard/dashboard.component';
import { EmployeComponent } from './employe/employe.component';
import { CongeComponent } from './conge/conge.component';
import { AutorisationComponent } from './autorisation/autorisation.component';
import { LoginComponent } from './login/login.component';
import { AuthGuardService } from './services/auth-guard.service';
import { ReinitialiserMotDePasseComponent } from './reinitialiser-mot-de-passe/reinitialiser-mot-de-passe.component';
import { DocumentationAdministrationComponent } from './documentation-administration/documentation-administration.component';
import { AvanceSalaireComponent } from './avance-salaire/avance-salaire.component';
import { AnomaliePointageComponent } from './anomalie-pointage/anomalie-pointage.component';
import { AnomaliePaieComponent } from './anomalie-paie/anomalie-paie.component';
import { AttestationAutorisationComponent } from './attestation-autorisation/attestation-autorisation.component';
import { EmissionComponent } from './emission/emission.component';
import { InfermerieComponent } from './infermerie/infermerie.component';
import { InterrogatoireComponent } from './interrogatoire/interrogatoire.component';
import { GestionValidateursComponent } from './gestion-validateurs/gestion-validateurs.component';

export const routes: Routes = [
  { path: 'login', component: LoginComponent }, // Login page
  { path: 'dashboard', component: DashboardComponent, canActivate: [AuthGuardService] },
{ path: 'employes', component: EmployeComponent, canActivate: [AuthGuardService], data: { roles: ['Responsable RH'] } },
{ path: 'conges', component: CongeComponent, canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','TECH sup maintenance','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT', 'Chef d\'equipe', 'GARDIEN','Directeur ','Ingenieur Methode','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique','TECH sup maintenance',"Chef de Groupe"] } },
{ path: 'autorisations', component: AutorisationComponent, canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','TECH sup maintenance','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT', 'Chef d\'equipe', 'GARDIEN','Directeur ','Ingenieur Methode','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Spécialiste import/export','Responsable AV','Chef service technique','TECH sup maintenance',"Chef de Groupe"] } },
{ path: 'reinitialiser-mot-de-passe', component: ReinitialiserMotDePasseComponent },
{ path: 'document', component: DocumentationAdministrationComponent, canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','TECH sup maintenance','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT', 'Chef d\'equipe','GARDIEN','Ingenieur Methode','Directeur ','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique','TECH sup maintenance',"Chef de Groupe"] } },
{ path: 'salaire', component: AvanceSalaireComponent, canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','TECH sup maintenance','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT', 'Chef d\'equipe','GARDIEN','Directeur ','Ingenieur Methode','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique','TECH sup maintenance',"Chef de Groupe"] } },
{ path: 'pointage', component: AnomaliePointageComponent, canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','TECH sup maintenance','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT', 'Chef d\'equipe','GARDIEN','Directeur ','Ingenieur Methode','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique','TECH sup maintenance',"Chef de Groupe"] } },
{ path: 'anomalies-paie', component: AnomaliePaieComponent , canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','TECH sup maintenance','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT', 'Chef d\'equipe','GARDIEN','Directeur ','Ingenieur Methode','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique','TECH sup maintenance',"Chef de Groupe"] } },
{path: 'attestation', component: AttestationAutorisationComponent,canActivate:[AuthGuardService],data:{roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','TECH sup maintenance','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT', 'Chef d\'equipe','GARDIEN','Directeur ','Ingenieur Methode','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique','TECH sup maintenance',"Chef de Groupe"] } },
{ path: 'emission', component: EmissionComponent , canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT','Directeur ','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique'] } },
{ path: 'doctour', component: InfermerieComponent , canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT','Directeur ','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique'] } },
{ path: 'punition', component: InterrogatoireComponent , canActivate: [AuthGuardService], data: { roles: ['Responsable RH','Validateur Supérieur Hiérarchique','Sécurité','Agent de qualite','Agent Logistique','ASSISTANTE DE DIRECT','Directeur ','Spécialiste import/export','Responsable Production','Chef Service Cable','Responsable Qualité','Responsable Unité de production','Chef Service couture','Responsable AV','Chef service technique'] } },
{ path: 'gestion-validateurs', component: GestionValidateursComponent, canActivate: [AuthGuardService], data: { roles: ['Responsable RH'] } },

];

