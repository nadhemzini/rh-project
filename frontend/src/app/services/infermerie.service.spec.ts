import { TestBed } from '@angular/core/testing';

import { InfermerieService } from './infermerie.service';

describe('InfermerieService', () => {
  let service: InfermerieService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(InfermerieService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
