package com.exemple.rh.Entity;

public class ChangeValidateurDTO {
    private Long oldValidatorId;
    private Long newValidatorId;

    public Long getOldValidatorId() {
        return oldValidatorId;
    }

    public void setOldValidatorId(Long oldValidatorId) {
        this.oldValidatorId = oldValidatorId;
    }

    public Long getNewValidatorId() {
        return newValidatorId;
    }

    public void setNewValidatorId(Long newValidatorId) {
        this.newValidatorId = newValidatorId;
    }
}
