package com.example.gatn.Entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "discount_detail_product")
public class DiscountDetailProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "soluong")
    private int soLuong;

    @Column(name = "soluongsanphamdatang")
    private int soluongSanPhamDaTang;

    @Column(name = "trangthai")
    private int trangThai;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_product_detail")
    private ProductDetail productDetail;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_discount_period")
    private DiscountPeriod discountPeriod;

}
