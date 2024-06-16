package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClientReponsitory extends JpaRepository<Client,Integer> {
    Optional<Client> getClientByEmailAndPassword(String email, String password);

    Client getClientByEmail(String email);
}
