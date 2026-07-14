import { TestBed } from '@angular/core/testing';

import { InterrogatoireService } from './interrogatoire.service';

describe('InterrogatoireService', () => {
  let service: InterrogatoireService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(InterrogatoireService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
