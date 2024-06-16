package com.example.gatn.Service;

import com.example.gatn.Entity.Client;
import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.ProductDetail;
import org.springframework.data.domain.Page;

import java.util.List;

public interface OrderService {
    void add(Order order);

    Order getorderbyclient(Client client, Integer status);

    List<Order> getallbystatus(int status);

    List<Order> getall();

    Page<Order> getOrdersByStatusAndPage(int pageNo, int pageSize,int status);

    Page<Order> getAllOrders(int pageNo, int pageSize);

    void delete(Integer id);

    Order getOrderById(Integer id);

    void update(Order order);

}
