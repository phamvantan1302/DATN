package com.example.gatn.Entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "discount_detail_order")
public class DiscountDetailOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_order")
    private Order order;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_sptangkem")
    private ProductDetail productDetail;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_discount_period")
    private DiscountPeriod discountPeriod;

    @Column(name = "discount_amount")
    private float discountAmount;

    @Column(name = "before_reduction")
    private float beforeReduction;

    @Column(name = "after_reduction")
    private float afterReduction;

    @Column(name = "soluongsp")
    private Integer soluongsp;
}
