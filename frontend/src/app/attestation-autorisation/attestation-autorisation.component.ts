import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { EmployeService } from '../services/employe.service';
import jsPDF from 'jspdf';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-attestation-autorisation',
  standalone: true,
  imports: [CommonModule,ReactiveFormsModule],
  templateUrl: './attestation-autorisation.component.html',
  styleUrl: './attestation-autorisation.component.css'
})
export class AttestationAutorisationComponent {
form: FormGroup;

 constructor(private fb: FormBuilder , private employeService: EmployeService) {
    this.form = this.fb.group({
      genre: [''],
      nom: [''],
      qualiteDeclarant: [''],
        genreAtteste: [''],
      nomAtteste: [''],
      cin: [''],
      dateNaissance: [''],
      dateRecrutement: [''],
      qualiteTravail: [''],
      lieu: [''],
      dateActuelle: [''],
      matricule: ['']
    });
 this.form.get('matricule')?.valueChanges.subscribe(matricule => {
  if (matricule && matricule.length >= 1) {
    this.employeService.getEmployeByMatricule(matricule).subscribe({
      next: (employe) => {
        console.log('✔️ Employé trouvé :', employe);
        this.form.patchValue({
          nomAtteste: employe.fullname,
          qualiteTravail: employe.role
        });
      },
      error: (err) => {
        console.error('❌ Erreur lors de la récupération de l\'employé :', err);
        this.form.patchValue({
          nomAtteste: '',
          qualiteTravail: ''
        });
      }
    });
  }
});
this.form.get('dateActuelle')?.setValue(new Date().toISOString().substring(0, 10));

 }


  async voirPDF() {
  const data = this.form.value;
  const doc = new jsPDF();

  // 👉 Déclarer la largeur de la page
  const pageWidth = doc.internal.pageSize.getWidth();

  // 👉 Charger le logo
  const logoDataUrl = await this.convertImageToBase64('assets/KKT.png');

  // 🖼️ Centrer le logo en haut
if (logoDataUrl) {
  const logoWidth = 100;
  const logoHeight = 45;
  const logoX = (pageWidth - logoWidth) / 2;
  const logoY = 5; // position verticale

  doc.addImage(logoDataUrl, 'PNG', logoX, logoY, logoWidth, logoHeight);
}


  // 🏷️ Titre centré sous le logo
 // 🏷️ Titre centré sous le logo
 doc.setFont('Helvetica', 'bold');
doc.setFontSize(14);
const titre = 'ATTESTATION DE TITULARISATION';
const titreY = 100; // Position Y du titre

// Afficher le titre
doc.text(titre, pageWidth / 2, titreY, { align: 'center' });

// 🔽 Souligner le titre avec une ligne
const titreWidth = doc.getTextWidth(titre);
const startX = (pageWidth - titreWidth) / 2;
const endX = startX + titreWidth;
doc.setLineWidth(0.5);
doc.line(startX, titreY + 2, endX, titreY + 2); // Ligne sous le texte
doc.setFont('Helvetica', 'bold');
  doc.setFontSize(11);
let y = titreY + 20
  const declarantGenre = data.genre || '...';
  const attesteGenre = data.genreAtteste || '...';

  const lignes = [
    `Je soussigné(e) ${declarantGenre} ${data.nom || '...................'}, agissant en qualité de ${data.qualiteDeclarant || '...................'},`,
    `atteste par la présente que ${attesteGenre} ${data.nomAtteste || '...................'} titulaire de la CIN N° ${data.cin || '...............'},`,
    `né(e) le ${data.dateNaissance || '...............'}, fait partie du personnel de la société, depuis le ${data.dateRecrutement || '...............'},`,
    `et travaille en qualité de ${data.qualiteTravail || '...................'}.`,
    '',
    `Cette attestation est délivrée à l'intéressé(e) sur sa demande pour servir et valoir ce que de droit.`,
    '',
    `Fait à ${data.lieu || '................'}, le ${data.dateActuelle || '................'}.`
  ];

for (const ligne of lignes) {
  doc.text(ligne, 20, y);
  y += 10;
}

  doc.text("Signature de l'employé :", 20, y + 15);
  doc.text("Signature et cachet de l'employeur :", 110, y + 15);

  // ✅ Affichage du PDF dans un nouvel onglet
  window.open(doc.output('bloburl'), '_blank');
}


   convertImageToBase64(url: string): Promise<string> {
    return new Promise((resolve, reject) => {
      const img = new Image();
      img.crossOrigin = 'Anonymous'; // nécessaire si hébergé sur un autre domaine
      img.onload = () => {
        const canvas = document.createElement('canvas');
        canvas.width = img.width;
        canvas.height = img.height;
        const ctx = canvas.getContext('2d');
        ctx?.drawImage(img, 0, 0);
        resolve(canvas.toDataURL('image/png'));
      };
      img.onerror = (err) => reject(err);
      img.src = url;
    });
  }
}
