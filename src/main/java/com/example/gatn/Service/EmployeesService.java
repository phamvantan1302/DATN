package com.example.gatn.Service;

import com.example.gatn.Entity.Employees;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface EmployeesService {
    Optional<Employees> findByNameAccountAndPassword(String nameAccount, String password);

    Page<Employees> getlist(Pageable pageable);

    void add(Employees employees);

    Employees getonebyid(Integer id);

    void update(Employees employees);
}
