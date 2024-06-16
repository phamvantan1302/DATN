package com.example.gatn.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "product_detail")
public class ProductDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_category")
    private Category category;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_size")
    private Size size;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_product")
    private Product product;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_material")
    private Material material;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_brand")
    private Brand brand;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_color")
    private Color color;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_sole")
    private Sole sole;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_lace")
    private Lace lace;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_sockliner")
    private Sockliner sockliner;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "describe")
    private String describe;

    @Column(name = "gender")
    private boolean gender;

    @Column(name = "price")
    private float price;

    @Column(name = "status")
    private Integer status;

    @Column(name = "barcode")
    private String barcode;

    @OneToMany(mappedBy = "productDetail")
    @JsonIgnore
    private List<Image> images;



}
