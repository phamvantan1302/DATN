package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.Client;
import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.OrderDetail;
import com.example.gatn.Entity.ProductDetail;
import com.example.gatn.Repositoris.OrderDetailReponsitory;
import com.example.gatn.Service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderDetailImpl implements OrderDetailService {
    @Autowired
    private OrderDetailReponsitory orderDetailReponsitory;



    @Override
    public List<OrderDetail> getallbyOrder(Order order) {
        return orderDetailReponsitory.getOrderDetailsByOrder(order);
    }

    @Override
    public void delete(OrderDetail orderDetail) {
        orderDetailReponsitory.delete(orderDetail);
    }

    @Override
    public void add(OrderDetail orderDetail) {
        orderDetailReponsitory.save(orderDetail);
    }

    @Override
    public Optional<OrderDetail> getonebyid(Integer id) {
        return orderDetailReponsitory.findById(id);
    }


    @Override
    public OrderDetail getorderbyProductDetailandOrder(Order order, ProductDetail productDetail) {
        return orderDetailReponsitory.getOrderDetailByOrderAndProductDetail(order,productDetail);
    }

    @Override
    public void Update(OrderDetail orderDetail) {
        orderDetailReponsitory.save(orderDetail);
    }

    @Override
    public void deletebyid(Integer id) {
        orderDetailReponsitory.deleteById(id);
    }
}
