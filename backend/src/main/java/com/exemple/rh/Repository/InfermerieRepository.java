package com.exemple.rh.Repository;

import com.exemple.rh.Entity.Infermerie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InfermerieRepository extends JpaRepository<Infermerie, Long> {
}

