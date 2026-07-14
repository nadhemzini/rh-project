import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InterrogatoireComponent } from './interrogatoire.component';

describe('InterrogatoireComponent', () => {
  let component: InterrogatoireComponent;
  let fixture: ComponentFixture<InterrogatoireComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InterrogatoireComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(InterrogatoireComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
