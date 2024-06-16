package com.example.gatn.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "employees")
public class Employees {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "code", length = 50)
    private String code;

    @Column(name = "full_name", length = 100)
    private String fullName;

    @Column(name = "name_account", length = 50)
    private String nameAccount;

    @Column(name = "password", length = 50)
    private String password;

    @Column(name = "line", length = 200)
    private String line;

    @Column(name = "city", length = 200)
    private String city;

    @Column(name = "country", length = 200)
    private String country;

    @Column(name = "province", length = 200)
    private String province;

    @Column(name = "date_of_birth")
    private Date dateOfBirth;

    @Column(name = "phone_number", length = 20)
    private String phoneNumber;

    @Column(name = "email", length = 50)
    private String email;

    @Column(name = "roles", length = 50)
    private String roles;

    @Column(name = "create_date")
    private Date createDate;

    @Column(name = "gender")
    private boolean gender;

    @Column(name = "status")
    private Integer status;

    @Column(name = "img")
    private String img;
}
