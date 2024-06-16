package com.example.gatn.ViewModel;

import com.example.gatn.Entity.DiscountDetailOrder;
import com.example.gatn.Entity.DiscountDetailProduct;
import com.example.gatn.Entity.DiscountPeriod;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ListDiscountView {
    List<DiscountDetailOrder> discountDetailOrder;
    List<DiscountDetailProduct> discountDetailProduct;
}
