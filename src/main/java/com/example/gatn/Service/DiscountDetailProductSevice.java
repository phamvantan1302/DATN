package com.example.gatn.Service;

import com.example.gatn.Entity.DiscountDetailProduct;
import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Entity.ProductDetail;
import org.springframework.data.domain.Page;

import java.util.List;

public interface DiscountDetailProductSevice {
    List<DiscountDetailProduct> getall();

    List<DiscountDetailProduct> getallfindiscount(DiscountPeriod discountPeriod);

    DiscountDetailProduct getallbyProductDetail(ProductDetail productDetail,DiscountPeriod discountPeriod);

    DiscountDetailProduct getonebyid(Integer id);

    void delete(Integer id);

    void deletebydiscount(Integer Id);

    void add(DiscountDetailProduct discountDetailProduct);

    void update(DiscountDetailProduct discountDetailProduct);
}
