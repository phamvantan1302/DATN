package com.example.gatn.Service;

import com.example.gatn.Entity.Client;
import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.OrderDetail;
import com.example.gatn.Entity.ProductDetail;

import java.util.List;
import java.util.Optional;

public interface OrderDetailService {


    List<OrderDetail> getallbyOrder(Order order);


    void delete(OrderDetail orderDetail);

    void deletebyid(Integer id);

    void add(OrderDetail orderDetail);

    Optional<OrderDetail> getonebyid(Integer id);

    OrderDetail getorderbyProductDetailandOrder(Order order, ProductDetail productDetail);

    void Update(OrderDetail orderDetail);
}
