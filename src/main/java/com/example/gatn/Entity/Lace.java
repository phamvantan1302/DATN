package com.example.gatn.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "lace")
public class Lace {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "code")
    private String code;

    @Column(name = "name")
    private String name;

    @Column(name = "lenght")
    private float length;

    @Column(name = "status")
    private Integer status;

    @OneToMany(mappedBy = "lace", fetch = FetchType.EAGER)
    @JsonIgnore
    private List<ProductDetail> productDetails;
}
