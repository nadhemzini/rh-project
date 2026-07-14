import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfermerieComponent } from './infermerie.component';

describe('InfermerieComponent', () => {
  let component: InfermerieComponent;
  let fixture: ComponentFixture<InfermerieComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfermerieComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(InfermerieComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
