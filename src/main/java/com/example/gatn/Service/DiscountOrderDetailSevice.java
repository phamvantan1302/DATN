package com.example.gatn.Service;

import com.example.gatn.Entity.DiscountDetailOrder;
import com.example.gatn.Entity.DiscountDetailProduct;
import com.example.gatn.Entity.Order;

import java.util.List;

public interface DiscountOrderDetailSevice {
    void add(DiscountDetailOrder discountDetailOrder);
    void Update(DiscountDetailOrder discountDetailOrder);
    List<DiscountDetailOrder> getdistcountbyorder(Order order);
    void delete(DiscountDetailOrder discountDetailOrder);

}
