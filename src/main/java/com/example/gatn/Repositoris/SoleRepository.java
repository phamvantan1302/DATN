package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Sole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SoleRepository extends JpaRepository<Sole, Integer> {
}
