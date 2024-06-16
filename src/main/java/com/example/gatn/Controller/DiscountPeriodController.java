package com.example.gatn.Controller;

import com.example.gatn.Entity.DiscountDetailProduct;
import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Entity.ProductDetail;
import com.example.gatn.Repositoris.DiscountPeriodReponsitory;
import com.example.gatn.Service.DiscountDetailProductSevice;
import com.example.gatn.Service.DiscountPeriodService;
import com.example.gatn.Service.Impl.DiscountPeriodImpl;
import com.example.gatn.Service.Impl.DiscountProductDetailImpl;
import com.example.gatn.Service.Impl.ProductDetailImpl;
import com.example.gatn.Service.ProductDetailService;
import com.example.gatn.ViewModel.DiscountperiodView;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@RestController
@RequestMapping("admin")
public class DiscountPeriodController {
    @Autowired
    DiscountPeriodService discountPeriodService = new DiscountPeriodImpl();

    @Autowired
    DiscountPeriodReponsitory discountPeriodReponsitory;

    @Autowired
    DiscountDetailProductSevice discountDetailProductSevice = new DiscountProductDetailImpl();

    @Autowired
    ProductDetailService productDetailService = new ProductDetailImpl();


    List<ProductDetail> newlist ;


    @GetMapping("DiscountPeriods")
    public ResponseEntity<Page<DiscountPeriod>> getall(@RequestParam int page, @RequestParam int size){
        Page<DiscountPeriod> paged= discountPeriodService.getpageall(page, size);
        return new ResponseEntity<>(paged, HttpStatus.OK);
    }

    @GetMapping("/DiscountPeriods/{status}")
    public ResponseEntity<Page<DiscountPeriod>> getDiscountPeriodsByStatus(
            @PathVariable int status,
            @RequestParam int page,
            @RequestParam int size) {

        Page<DiscountPeriod> discountPeriods = discountPeriodService.getDiscountPeriodsByStatus(status, page, size);
        return ResponseEntity.ok(discountPeriods);
    }


    // API để tìm kiếm dữ liệu với các thuộc tính tùy chọn

    @GetMapping("DiscountPeriods/search")
    public ResponseEntity<Page<DiscountPeriod>> searchDiscountPeriods(@RequestParam String keyword,
                                                                      @RequestParam int page,
                                                                      @RequestParam int size) {
        Page<DiscountPeriod> result = discountPeriodService.searchDiscountPeriods(keyword,page,size);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("DetailDiscountPeriod/{id}")
    public ResponseEntity<?> getonebyid(@PathVariable("id") Integer id){
        try {
            DiscountPeriod discountPeriod = discountPeriodService.getonebyid(id);
            return new ResponseEntity<>(discountPeriod, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error retrieving discount period detail: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("DeleteDiscountPeriod/{id}")
    public ResponseEntity<DiscountPeriod> delete(@PathVariable("id") Integer id){
        DiscountPeriod discountPeriod = discountPeriodService.getonebyid(id);
        discountPeriod.setStatus(2);
        discountPeriodService.update(discountPeriod);
         return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
    @PostMapping("listSelectedProducts")
    public ResponseEntity<String> saveSelectedProducts(@RequestBody List<ProductDetail> selectedProductDetails) {
        newlist = selectedProductDetails;
        return new ResponseEntity<>( HttpStatus.OK);
    }

    @PostMapping("DiscountPeriod")
    public ResponseEntity<?> post(@RequestBody @Valid DiscountperiodView discountperiodview, BindingResult result){
        Map<String, String> errors = new HashMap<>();

        if (result.hasErrors() || discountperiodview.getStarPrice() == 0.0 || discountperiodview.getEndPrice() == 0.0 || discountperiodview.getQuantity() == 0.0) {
            if (result.hasErrors()) {
                for (FieldError error : result.getFieldErrors()) {
                    errors.put(error.getField(), error.getDefaultMessage());
                }
            }

            if (discountperiodview.getStarPrice() == 0.0) {
                errors.put("starPrice", "Giá Bắt Đầu không được để trống");
            }
            if (discountperiodview.getEndPrice() == 0.0) {
                errors.put("endPrice", "Giá kết thúc không được để trống");
            } else if (discountperiodview.getEndPrice() <= discountperiodview.getStarPrice()) {
                errors.put("endPrice", "Giá kết thúc phải lớn hơn giá bắt đầu");
            }

            if (discountperiodview.getQuantity() == 0.0) {
                errors.put("quantity", "Số lượng không được để trống");
            }
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }

        String startDateStr = discountperiodview.getStartDate();
        String endDateStr = discountperiodview.getEndDate();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX");

        LocalDate localStartDate = LocalDate.parse(startDateStr, formatter);
        LocalDate localEndDate = LocalDate.parse(endDateStr, formatter);
        LocalDate today = LocalDate.now();

        if (startDateStr != null && endDateStr != null) {
            if (localStartDate.isAfter(localEndDate)) {
                errors.put("endDate", "Ngày kết thúc phải sau ngày bắt đầu");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
        }
        if (startDateStr != null && endDateStr != null) {
            if (localEndDate.isBefore(today)) {
                errors.put("endDate", "Ngày kết thúc phải sau ngày hôm nay");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
        }
        if ( discountperiodview.getStarPrice()<1000) {
            errors.put("starPrice", "Giá bắt đầu phải lớn hơn 1000");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
        if (discountperiodview.getEndPrice() < 1000) {
            errors.put("endPrice", "Giá kết thúc phải lớn hơn 1000");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }

        if (discountperiodview.getEndPrice() <= discountperiodview.getStarPrice()) {
            errors.put("endPrice", "Giá kết thúc phải lớn hơn giá bắt đầu");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }

        if (today.isAfter(localStartDate) && today.isBefore(localEndDate)) {
            discountperiodview.setStatus(0);
        } else  {
            discountperiodview.setStatus(1);
        }
        if (discountperiodview.getApDungCTKMKhac()==null){
            discountperiodview.setApDungCTKMKhac(false);
        }else {
            discountperiodview.setApDungCTKMKhac(true);
        }


        if (discountperiodview.getCategory()==0){
            if (discountperiodview.getValue()==0.0){
                errors.put("value", "% giảm không được để chống");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            if (discountperiodview.getValue()>=100){
                errors.put("value", "% giảm không được lớn hơn 100%");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            if (discountperiodview.getGiamToiDa()==0.0){
                errors.put("giamToiDa", "Tổng tiền giảm không được để chống");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            if (discountperiodview.getTonggiatritckm() == 0.0) {
                errors.put("tonggiatritckm", "Số lượng không được để trống");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }if (discountperiodview.getTonggiatritckm() < 100000.0) {
                errors.put("tonggiatritckm", "phải lớn 100,000 VND");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            if (discountperiodview.getGiamToiDa() < 10000.0) {
                errors.put("giamToiDa", "phải lớn 10,000 VND");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            DiscountPeriod discountPeriod1 = new DiscountPeriod();
            BeanUtils.copyProperties(discountperiodview,discountPeriod1);
                    discountPeriodReponsitory.save(discountPeriod1);
        }else if (discountperiodview.getCategory()==1){
            DiscountPeriod discountPeriod1 = new DiscountPeriod();
            BeanUtils.copyProperties(discountperiodview,discountPeriod1);
            discountPeriodReponsitory.save(discountPeriod1);
                for (int i = 0; i < newlist.size(); i++) {
                    DiscountDetailProduct discountDetailProduct= new DiscountDetailProduct();
                    discountDetailProduct.setDiscountPeriod(discountPeriod1);
                    discountDetailProduct.setProductDetail(newlist.get(i));
                    discountDetailProduct.setSoLuong(1);
                    discountDetailProductSevice.add(discountDetailProduct);
                }
            }
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
    @PutMapping("UpdateDiscountPeriod/{id}")
    public ResponseEntity<?> put(@PathVariable("id") Integer id,@RequestBody DiscountPeriod newdiscountPeriod) {
        DiscountPeriod discountPeriod = discountPeriodService.getonebyid(id);
        Map<String, String> errors = new HashMap<>();
        if (newdiscountPeriod.getStarPrice() == 0.0) {
            errors.put("starPrice", "Giá Bắt Đầu không được để trống");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }

        if (newdiscountPeriod.getEndPrice() == 0.0) {
            errors.put("endPrice", "Giá kết thúc không được để trống");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        } else if (newdiscountPeriod.getEndPrice() <= newdiscountPeriod.getStarPrice()) {
            errors.put("endPrice", "Giá kết thúc phải lớn hơn giá bắt đầu");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }

        if (newdiscountPeriod.getQuantity() == 0.0) {
            errors.put("quantity", "Số lượng không được để trống");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
        if ( newdiscountPeriod.getStarPrice()<1000) {
            errors.put("starPrice", "Giá bắt đầu phải lớn hơn 1000");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
        if (newdiscountPeriod.getEndPrice() < 1000) {
            errors.put("endPrice", "Giá kết thúc phải lớn hơn 1000");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }

        if (newdiscountPeriod.getEndPrice() <= newdiscountPeriod.getStarPrice()) {
            errors.put("endPrice", "Giá kết thúc phải lớn hơn giá bắt đầu");
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
        if (newdiscountPeriod.getCategory() == 0) {
            if (newdiscountPeriod.getValue()==0.0){
                errors.put("value", "% giảm không được để chống");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            if (newdiscountPeriod.getValue()>=100){
                errors.put("value", "% giảm không được lớn hơn 100%");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            if (newdiscountPeriod.getGiamToiDa()==0.0){
                errors.put("giamToiDa", "Tổng tiền giảm không được để chống");
                return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
            }
            DiscountPeriod old_discountperiod = discountPeriodService.getonebyid(id);
            BeanUtils.copyProperties(newdiscountPeriod, old_discountperiod);
            discountPeriodService.update(old_discountperiod);
            List<DiscountDetailProduct> listdiscountdetailProduct = discountDetailProductSevice.getallfindiscount(old_discountperiod);
            if (listdiscountdetailProduct != null) {
                for (int i = 0; i < listdiscountdetailProduct.size(); i++) {
                    DiscountDetailProduct discountDetailProduct = listdiscountdetailProduct.get(i);
                    discountDetailProduct.setTrangThai(1);
                    discountDetailProductSevice.update(discountDetailProduct);
                }
            }
        } else if (newdiscountPeriod.getCategory() == 1) {
            newdiscountPeriod.setValue(0);
            newdiscountPeriod.setGiamToiDa(0);
            DiscountPeriod discountPeriod1 = discountPeriodReponsitory.save(newdiscountPeriod);
            if (newlist.size()>0){
                List<DiscountDetailProduct> discountDetailProductList = discountDetailProductSevice.getallfindiscount(discountPeriod);
                for (int i = 0; i < discountDetailProductList.size(); i++) {
                    DiscountDetailProduct discountDetailProduct=discountDetailProductList.get(i);
                    discountDetailProduct.setTrangThai(1);
                    discountDetailProductSevice.update(discountDetailProduct);
                }
                for (int i = 0; i < newlist.size(); i++) {
                    DiscountDetailProduct discountDetailProduct = discountDetailProductSevice.getallbyProductDetail(newlist.get(i), newdiscountPeriod);
                    if (discountDetailProduct == null) {
                        DiscountDetailProduct discountDetailProduct1 = new DiscountDetailProduct();
                        discountDetailProduct1.setDiscountPeriod(newdiscountPeriod);
                        discountDetailProduct1.setProductDetail(newlist.get(i));
                        discountDetailProductSevice.update(discountDetailProduct1);
                    }else {
                        discountDetailProduct.setTrangThai(0);
                        discountDetailProductSevice.update(discountDetailProduct);
                    }
                }
            }
        }
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}

