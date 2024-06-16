package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.Client;
import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.ProductDetail;
import com.example.gatn.Repositoris.OrderReponsitory;
import com.example.gatn.Service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderImpl implements OrderService {
    @Autowired
    private OrderReponsitory orderReponsitory ;


    @Override
    public void add(Order order) {
        orderReponsitory.save(order);
    }

    @Override
    public List<Order> getallbystatus(int status) {
        return orderReponsitory.findAllByStatus(status);
    }

    @Override
    public Order getorderbyclient(Client client, Integer status) {
        return orderReponsitory.getOrderByClientAndStatus(client,status);
    }

    @Override
    public List<Order> getall() {
        return orderReponsitory.findAll();
    }

    @Override
    public Page<Order> getOrdersByStatusAndPage(int status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderReponsitory.findByStatus(status,pageable);
    }

    @Override
    public Page<Order> getAllOrders(int pageNo, int pageSize) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        return orderReponsitory.findAll(pageable);
    }

    @Override
    public void delete(Integer id) { orderReponsitory.deleteById(id);
    }

    @Override
    public Order getOrderById(Integer id) {
        return orderReponsitory.getOrderById(id);
    }

    @Override
    public void update(Order order) {
        orderReponsitory.save(order);
    }


}
