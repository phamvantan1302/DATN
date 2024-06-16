package com.example.gatn.Controller;

import com.example.gatn.Entity.ActivityLog;
import com.example.gatn.Entity.Employees;
import com.example.gatn.Service.Activity_logService;
import com.example.gatn.Service.Impl.Activity_logImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Calendar;
import java.util.Date;

@Controller
public class LogoutController {
    @Autowired
    private Activity_logService activity_logService = new Activity_logImpl();
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // Lấy session hiện tại, không tạo mới nếu không tồn tại
        if (session != null) {
            Employees loggedInEmployee = (Employees) session.getAttribute("nhanvien");
            ActivityLog activityLog = new ActivityLog();
            Calendar currentDateTime = Calendar.getInstance();
            Date currentDate = currentDateTime.getTime();
            activityLog.setTimestamp(currentDate);
            activityLog.setAction("Đăng Xuất");
            activityLog.setStaff(loggedInEmployee);
            activity_logService.add(activityLog);

            // Xóa session
            session.invalidate();
            return "redirect:/admin/login";
        } else {
            // Trường hợp không có session
            return "redirect:/admin/login";
        }
    }
}
