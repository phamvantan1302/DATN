package com.example.gatn.ViewModel;
import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Entity.ProductDetail;
import jakarta.persistence.Column;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class DiscountperiodView {
     @NotBlank(message = "Không được để trống")
     private String name;

     @NotBlank(message = "Không được để trống")
     private String startDate;

     @NotBlank(message = "Không được để trống")
     private String endDate;

     private float value;

     @NotNull(message = "không được để trống")
     private double starPrice;

     @NotNull(message = "không được để trống")
     private double endPrice;

     private Boolean apDungCTKMKhac;

     @NotNull(message = "không được để trống")
     private float quantity;

     @NotNull(message = "không được để trống")
     private int category;

     @NotNull(message = "không được để trống")
     private int status;

     private double giamToiDa;

     private double tonggiatritckm;
}
