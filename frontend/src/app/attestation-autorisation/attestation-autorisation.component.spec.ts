import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AttestationAutorisationComponent } from './attestation-autorisation.component';

describe('AttestationAutorisationComponent', () => {
  let component: AttestationAutorisationComponent;
  let fixture: ComponentFixture<AttestationAutorisationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AttestationAutorisationComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AttestationAutorisationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
