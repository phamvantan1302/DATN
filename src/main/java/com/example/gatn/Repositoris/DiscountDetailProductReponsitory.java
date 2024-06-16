package com.example.gatn.Repositoris;

import com.example.gatn.Entity.DiscountDetailProduct;
import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Entity.ProductDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiscountDetailProductReponsitory extends JpaRepository<DiscountDetailProduct,Integer> {

    List<DiscountDetailProduct> findAllByDiscountPeriod(DiscountPeriod discountPeriod);

    DiscountDetailProduct findAllByProductDetailAndDiscountPeriod(ProductDetail productDetail,DiscountPeriod discountPeriod);
}
