package com.example.gatn.Service;

import com.example.gatn.Entity.Voucher;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class VoucherService1 {

    private final EmailService emailService;

    @Autowired
    public VoucherService1(EmailService emailService) {
        this.emailService = emailService;
    }

    public void createAndSendVouchers(List<String> emailList, Voucher voucher) {
        for (String email : emailList) {
            try {
                emailService.sendVoucherCode(email, voucher);
                // Lưu thông tin voucher hoặc thực hiện các tác vụ khác ở đây
            } catch (Exception e) {
                // Xử lý lỗi khi gửi email
                e.printStackTrace();
            }
        }
    }
}
