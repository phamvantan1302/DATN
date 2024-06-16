package com.example.gatn.Controller;

import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Service.DiscountDetailProductSevice;
import com.example.gatn.Service.Impl.DiscountProductDetailImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("admin")
public class DiscountDetailProductController {
    @Autowired
    DiscountDetailProductSevice discountDetailProductSevice = new DiscountProductDetailImpl();

}
