import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AnomaliePaieComponent } from './anomalie-paie.component';

describe('AnomaliePaieComponent', () => {
  let component: AnomaliePaieComponent;
  let fixture: ComponentFixture<AnomaliePaieComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AnomaliePaieComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AnomaliePaieComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
