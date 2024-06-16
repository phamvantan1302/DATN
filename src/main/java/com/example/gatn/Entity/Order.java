package com.example.gatn.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
@Table(name = "orderr")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_employees")
    private Employees employees;

    @ManyToOne
    @JoinColumn(name = "id_client")
    private Client client;

    @ManyToOne
    @JoinColumn(name = "id_payment_method")
    private PaymentMethod paymentMethod;

    @Column(name = "code")
    private String code;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "sdtnhanhang")
    private String sdtnhanhang;

    @Column(name = "address")
    private String address;

    @Column(name = "use_name")
    private String useName;

    @Column(name = "nguoinhan")
    private String nguoinhan;

    @Column(name = "email")
    private String email;

    @Column(name = "item_discount")
    private String itemDiscount;

    @Column(name = "total_money")
    private double totalMoney;

    @Column(name = "confirmed_date")
    private Date confirmedDate;

    @Column(name = "ship_date")
    private Date shipDate;

    @Column(name = "completion_date")
    private Date completionDate;

    @Column(name = "note")
    private String note;

    @Column(name = "money_ship")
    private double moneyShip;

    @Column(name = "create_date")
    private Date createDate;

    @Column(name = "date_of_payment")
    private Date dateOfPayment;

    @Column(name = "last_moddified_date")
    private Date lastModifiedDate;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "tongtienhang")
    private double tongtienhang;

    @Column(name = "hinhthucthanhtoan")
    private int hinhthucthanhtoan;

    @Column(name = "chietkhau")
    private double chietkhau;

    @Column(name = "status")
    private Integer status;
}
