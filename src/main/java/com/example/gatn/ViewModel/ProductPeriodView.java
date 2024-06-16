package com.example.gatn.ViewModel;

import com.example.gatn.Entity.*;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductPeriodView {
    ProductDetail productDetail;
    private int soluong;
}
