package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.DiscountDetailOrder;
import com.example.gatn.Entity.Order;
import com.example.gatn.Repositoris.DiscountOrderDetailreponsitory;
import com.example.gatn.Service.DiscountOrderDetailSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiscountDetailOrderImpl implements DiscountOrderDetailSevice {
    @Autowired
    private DiscountOrderDetailreponsitory discountOrderDetailreponsitory;
    @Override
    public void add(DiscountDetailOrder discountDetailOrder) {
        discountOrderDetailreponsitory.save(discountDetailOrder);
    }

    @Override
    public void Update(DiscountDetailOrder discountDetailOrder) {
        discountOrderDetailreponsitory.save(discountDetailOrder);
    }

    @Override
    public List<DiscountDetailOrder> getdistcountbyorder(Order order) {
        return discountOrderDetailreponsitory.getDiscountDetailOrdersByOrder(order);
    }

    @Override
    public void delete(DiscountDetailOrder discountDetailOrder) {
        discountOrderDetailreponsitory.delete(discountDetailOrder);
    }


}
