package com.example.gatn.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Getter
@AllArgsConstructor
@Setter
@NoArgsConstructor
@Entity
@Builder
@Table(name = "sole")
public class Sole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "code")
    private String code;

    @Column(name = "name")
    private String name;

    @Column(name = "material")
    private String material;

    @Column(name = "status")
    private Integer status;

    @OneToMany(mappedBy = "sole", fetch = FetchType.EAGER)
    @JsonIgnore
    private List<ProductDetail> productDetails;
}
