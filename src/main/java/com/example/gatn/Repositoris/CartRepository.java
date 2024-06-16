package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Cart;
import com.example.gatn.Entity.Client;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepository extends JpaRepository<Cart, Integer> {
    Cart getCartByClientAndStatus(Client client,Integer status);
}
