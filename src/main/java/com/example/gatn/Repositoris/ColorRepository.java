package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Color;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ColorRepository extends JpaRepository<Color, Integer> {
    Color getColorByName(String Name);
}
