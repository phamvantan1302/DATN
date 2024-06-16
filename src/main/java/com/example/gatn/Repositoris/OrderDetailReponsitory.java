package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.OrderDetail;
import com.example.gatn.Entity.ProductDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface OrderDetailReponsitory extends JpaRepository<OrderDetail,Integer> {
        List<OrderDetail> getOrderDetailsByOrder(Order order);
        OrderDetail getOrderDetailByOrderAndProductDetail(Order order,ProductDetail productDetail);

        Page<OrderDetail> findOrderDetailByOrder(Order order , Pageable pageable);
}
