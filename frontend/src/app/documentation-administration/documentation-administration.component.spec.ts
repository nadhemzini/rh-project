import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocumentationAdministrationComponent } from './documentation-administration.component';

describe('DocumentationAdministrationComponent', () => {
  let component: DocumentationAdministrationComponent;
  let fixture: ComponentFixture<DocumentationAdministrationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DocumentationAdministrationComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(DocumentationAdministrationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
