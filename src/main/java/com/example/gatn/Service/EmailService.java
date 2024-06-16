package com.example.gatn.Service;

import com.example.gatn.Entity.Voucher;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender javaMailSender;

    public void sendVoucherToAllClients(List<String> clientEmails, Voucher voucher) {
        for (String clientEmail : clientEmails) {
            sendVoucherCode(clientEmail, voucher);
        }
    }

    void sendVoucherCode(String to, Voucher voucher) {
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper;

        try {
            helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject("Tặng Voucher");
            String htmlContent = "<html><body>"
                    + "<h2>Chào mừng bạn!</h2>"
                    + "<p>Dưới đây là mã voucher mới của bạn: <strong>" + voucher.getCode() + "</strong></p>"
                    + "<p>Mệnh giá: <span style='color: #e74c3c;'><mark>" + voucher.getValue() + "</mark> VND</span></p>"
                    + "<p>Hóa đơn tối thiểu khi mua: <span style='color: #3498db;'>" + voucher.getDieukienbatdau() + " VND</span></p>"
                    + "<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>"
                    + "</body></html>";
            // Gửi email
            helper.setText(htmlContent, true);
            javaMailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace(); // xử lý exception tùy ý
        }
    }
}
