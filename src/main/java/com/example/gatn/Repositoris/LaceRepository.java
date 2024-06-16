package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Lace;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LaceRepository extends JpaRepository<Lace, Integer> {
}
