package com.exemple.rh.Repository;

import com.exemple.rh.Entity.Autorisation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AutorisationRepository extends JpaRepository<Autorisation, Long> {
    @Query("SELECT a.employe, COUNT(a) as nb FROM Autorisation a WHERE a.statut = 'Accepté' GROUP BY a.employe ORDER BY nb DESC")
    List<Object[]> findTopEmployesByAutorisationsAcceptes();

}
