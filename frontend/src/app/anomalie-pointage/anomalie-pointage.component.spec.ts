import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AnomaliePointageComponent } from './anomalie-pointage.component';

describe('AnomaliePointageComponent', () => {
  let component: AnomaliePointageComponent;
  let fixture: ComponentFixture<AnomaliePointageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AnomaliePointageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AnomaliePointageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
