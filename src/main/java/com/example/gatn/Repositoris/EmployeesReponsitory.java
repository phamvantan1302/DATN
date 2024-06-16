package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Employees;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeesReponsitory extends JpaRepository<Employees,Integer> {
    Employees findByNameAccountAndPassword(String nameAccount, String password);
}
