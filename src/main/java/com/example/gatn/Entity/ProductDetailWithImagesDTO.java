package com.example.gatn.Entity;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductDetailWithImagesDTO {
    private ProductDetail productDetail;
    private List<String> imageUrls;
}
