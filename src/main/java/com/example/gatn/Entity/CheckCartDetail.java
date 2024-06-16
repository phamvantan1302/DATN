package com.example.gatn.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CheckCartDetail {
    private int id;
    private CheckCart cart;
    private ProductDetail productDetail;
    private int quantity;
    private double price;
    private float subtotal;

}
