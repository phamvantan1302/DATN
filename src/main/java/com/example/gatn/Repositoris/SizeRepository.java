package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SizeRepository extends JpaRepository<Size, Integer> {
    Size getSizeByName(String name);
}
