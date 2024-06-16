package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.Employees;
import com.example.gatn.Repositoris.EmployeesReponsitory;
import com.example.gatn.Service.EmployeesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
public class EmployeesImpl implements EmployeesService {
    @Autowired
    private EmployeesReponsitory employeesReponsitory;

    @Override
    public Optional<Employees> findByNameAccountAndPassword(String nameAccount, String password) {
        return Optional.ofNullable(employeesReponsitory.findByNameAccountAndPassword(nameAccount, password));
    }

    @Override
    public Page<Employees> getlist(Pageable pageable) {
        return employeesReponsitory.findAll(pageable);
    }

    @Override
    public void add(Employees employees) {
        employeesReponsitory.save(employees);
    }

    @Override
    public Employees getonebyid(Integer id) {
        Optional<Employees> o = employeesReponsitory.findById(id);
        return o.orElse(null) ;
    }

    @Override
    public void update(Employees employees) {
         employeesReponsitory.save(employees);
    }

}
