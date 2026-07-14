import { TestBed } from '@angular/core/testing';

import { AnomalieServiceService } from './anomalie-service.service';

describe('AnomalieServiceService', () => {
  let service: AnomalieServiceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AnomalieServiceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
