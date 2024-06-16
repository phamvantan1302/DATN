package com.example.gatn.Repositoris;

import com.example.gatn.Entity.DiscountDetailOrder;
import com.example.gatn.Entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiscountOrderDetailreponsitory extends JpaRepository<DiscountDetailOrder,Integer> {
    List<DiscountDetailOrder> getDiscountDetailOrdersByOrder(Order order);
}
