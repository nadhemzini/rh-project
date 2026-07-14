package com.exemple.rh.Repository;

import com.exemple.rh.Entity.AnomaliePointage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AnomaliePointageRepository extends JpaRepository<AnomaliePointage, Long> {

}

