package com.exemple.rh.Repository;

import com.exemple.rh.Entity.AnomaliePaie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnomaliePaieRepository extends JpaRepository<AnomaliePaie, Long> {
    List<AnomaliePaie> findByEmployeZone(String zone);

}
