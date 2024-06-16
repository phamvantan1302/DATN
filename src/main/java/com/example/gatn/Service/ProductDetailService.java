package com.example.gatn.Service;

import com.example.gatn.Entity.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductDetailService {
    List<ProductDetail> getall();

    List<ProductDetail>  getallbyDiscount(Integer discountPeriodId);

    ProductDetail getonebyid(Integer id);

    void add(ProductDetail productDetail);

    void update(ProductDetail productDetail);

    ProductDetail getonebybarcode(String barcode);

    Page<ProductDetail> getProductDetails(Pageable pageable);

    ProductDetail getById(Integer id);

    Page<ProductDetail> getlistchung(Pageable pageable);



    Page<ProductDetail> search(String key, Pageable pageable);

    Page<ProductDetail> getall(Integer key, Pageable pageable);

    Page<ProductDetail> getByMoney(Integer key, int a, int b, Pageable pageable);

    Page<ProductDetail> searchhome(String key,Integer status, Pageable pageable);

    }
