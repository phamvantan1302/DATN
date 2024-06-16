package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.*;
import com.example.gatn.Repositoris.ProductDetailReponsitoty;
import com.example.gatn.Service.ProductDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductDetailImpl implements ProductDetailService {

    @Autowired
    private ProductDetailReponsitoty productDetailReponsitoty;

    @Override
    public List<ProductDetail> getall() {
        return productDetailReponsitoty.findAll();
    }

    @Override
    public List<ProductDetail> getallbyDiscount(Integer DiscountperiodId) {
        return productDetailReponsitoty.findProductDetailsByDiscountPeriod(DiscountperiodId);
    }

    @Override
    public ProductDetail getonebyid(Integer Id) {
        return productDetailReponsitoty.getReferenceById(Id);
    }

    @Override
    public void add(ProductDetail productDetail) {
        productDetailReponsitoty.save(productDetail);
    }

    @Override
    public void update(ProductDetail productDetail) {
        productDetailReponsitoty.save(productDetail);
    }

    @Override
    public ProductDetail getonebybarcode(String barcode) {
        return productDetailReponsitoty.getProductDetailByBarcode(barcode);
    }

    @Override
    public Page<ProductDetail> getProductDetails(Pageable pageable) {
        return productDetailReponsitoty.findAll(pageable);
    }

    @Override
    public ProductDetail getById(Integer id) {
        return productDetailReponsitoty.getReferenceById(id);
    }

    @Override
    public Page<ProductDetail> getlistchung(Pageable pageable) {
        return productDetailReponsitoty.findDistinctProductDetails(pageable);
    }


    @Override
    public Page<ProductDetail> search(String key, Pageable pageable) {
        return productDetailReponsitoty.search(key, pageable);
    }

    @Override
    public Page<ProductDetail> getall(Integer key, Pageable pageable) {
        return productDetailReponsitoty.getByStatus(key, pageable);
    }

    public Page<ProductDetail> getByMoney(Integer key, int a, int b, Pageable pageable) {
        return productDetailReponsitoty.getByMoney(key, a, b, pageable);
    }

    @Override
    public Page<ProductDetail> searchhome(String key,Integer status, Pageable pageable) {
        return productDetailReponsitoty.searchHome(key,status, pageable);
    }


}
