import { TestBed } from '@angular/core/testing';

import { DemandeDocumentService } from './demande-document.service';

describe('DemandeDocumentService', () => {
  let service: DemandeDocumentService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DemandeDocumentService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
