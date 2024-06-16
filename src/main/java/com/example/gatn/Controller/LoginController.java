package com.example.gatn.Controller;

import com.example.gatn.Entity.ActivityLog;
import com.example.gatn.Entity.Employees;
import com.example.gatn.Service.Activity_logService;
import com.example.gatn.Service.EmployeesService;
import com.example.gatn.Service.Impl.Activity_logImpl;
import com.example.gatn.Service.Impl.EmployeesImpl;
import com.example.gatn.ViewModel.LoginRequest;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

@Controller
@RequestMapping("Admin")
public class LoginController {
    @Autowired
    private EmployeesService employeesService = new EmployeesImpl();

    @Autowired
    private Activity_logService activity_logService = new Activity_logImpl();

    @PostMapping("/login")
    public ResponseEntity<Map<String,String>> login(@RequestBody LoginRequest loginRequest, HttpServletRequest request, Model model) {
        // Kiểm tra tên người dùng và mật khẩu ở đây
        String username = loginRequest.getUsername();
        String password = loginRequest.getPassword();
        // Thực hiện kiểm tra đăng nhập bằng cách truy vấn cơ sở dữ liệu
        Optional<Employees> userOptional = employeesService.findByNameAccountAndPassword(username, password);

        System.out.println(userOptional.get().getId());
        if (userOptional.isPresent()) {
            HttpSession session = request.getSession();
            Employees loggedInEmployee = userOptional.get();
            session.setAttribute("nhanvien", loggedInEmployee);
            ActivityLog activityLog = new ActivityLog();
            activityLog.setStaff(userOptional.get());
            activityLog.setAction("Đăng Nhập");
            Calendar currentDateTime = Calendar.getInstance();
            Date currentDate = currentDateTime.getTime();
            activityLog.setTimestamp(currentDate);
            activity_logService.add(activityLog);
            Map<String, String> response = new HashMap<>();
            session.setAttribute("loggedInUser", loggedInEmployee);

            // Đặt thông tin người dùng vào model
            model.addAttribute("loggedInUser", loggedInEmployee);
            response.put("redirectUrl", "/admin/BanOff");
            return ResponseEntity.ok().body(response);
        } else {
            // Trả về lỗi khi không tìm thấy nhân viên
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Tài khoản không tồn tại");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
        }
    }


}
