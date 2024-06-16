package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Cart;
import com.example.gatn.Entity.CartDetail;
import com.example.gatn.Entity.ProductDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CartDetailRepository extends JpaRepository<CartDetail, Integer> {
    CartDetail getCartDetailByCartAndProductDetail(Cart cart, ProductDetail productDetail);

    Page<CartDetail> getCartDetailsByCart(Cart cart, Pageable pageable);

    List<CartDetail> getCartDetailsByCart(Cart cart);

}
