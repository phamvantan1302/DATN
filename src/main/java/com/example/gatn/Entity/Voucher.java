package com.example.gatn.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "voucher")
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "code")
    private String code;

    @Column(name = "value")
    private float value;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "menhgia")
    private double menhGia;

    @Column(name = "dieukienbatdau")
    private double dieukienbatdau;

    @Column(name = "apdungvoucherkhac")
    private boolean apdungvoucherkhac;

    @Column(name = "codevoucherchung")
    private String codevoucherchung;

    @Column(name = "ngaysudung")
    private Date ngaysudung;

    @Column(name = "status")
    private Integer status;
}
