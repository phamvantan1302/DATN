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
@Table(name = "sockliner")
public class Sockliner {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "code")
    private String code;

    @Column(name = "name")
    private String name;

    @Column(name = "color")
    private String color;

    @Column(name = "material")
    private String material;

    @Column(name = "status")
    private Integer status;

    @OneToMany(mappedBy = "sockliner", fetch = FetchType.EAGER)
    @JsonIgnore
    private List<ProductDetail> productDetails;

}
