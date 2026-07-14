import { TestBed } from '@angular/core/testing';

import { AnomaliePaieServiceService } from './anomalie-paie-service.service';

describe('AnomaliePaieServiceService', () => {
  let service: AnomaliePaieServiceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AnomaliePaieServiceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
