package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.DiscountDetailProduct;
import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Entity.ProductDetail;
import com.example.gatn.Repositoris.DiscountDetailProductReponsitory;
import com.example.gatn.Service.DiscountDetailProductSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DiscountProductDetailImpl implements DiscountDetailProductSevice {
    @Autowired
    private DiscountDetailProductReponsitory discountDetailProductReponsitory;

    @Override
    public List<DiscountDetailProduct> getall() {
        return discountDetailProductReponsitory.findAll();
    }

    @Override
    public List<DiscountDetailProduct> getallfindiscount(DiscountPeriod discountPeriod) {
        return discountDetailProductReponsitory.findAllByDiscountPeriod(discountPeriod);
    }

    @Override
    public DiscountDetailProduct getallbyProductDetail(ProductDetail productDetail,DiscountPeriod discountPeriod) {
        return discountDetailProductReponsitory.findAllByProductDetailAndDiscountPeriod(productDetail,discountPeriod);
    }

    @Override
    public DiscountDetailProduct getonebyid(Integer id) {
        return discountDetailProductReponsitory.getReferenceById(id);
    }

    @Override
    public void delete(Integer id) {
        discountDetailProductReponsitory.deleteById(id);
    }

    @Override
    public void deletebydiscount(Integer Id) {

    }

    @Override
    public void add(DiscountDetailProduct discountDetailProduct) {
        discountDetailProductReponsitory.save(discountDetailProduct);
    }

    @Override
    public void update(DiscountDetailProduct discountDetailProduct) {
        discountDetailProductReponsitory.save(discountDetailProduct);
    }
}
