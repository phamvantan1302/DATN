package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Sockliner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SocklinerRepository extends JpaRepository<Sockliner, Integer> {
}
