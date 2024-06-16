package com.example.gatn.Controller;

import com.example.gatn.Entity.Employees;
import com.example.gatn.Entity.ProductDetail;
import com.example.gatn.ViewModel.DiscountperiodView;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @GetMapping("DiscountPeriod")
    public String DiscountPeriod(Model model, HttpServletRequest request){
        // Kiểm tra xem có session nhân viên hay không
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("nhanvien") == null) {
            // Nếu không có session nhân viên, đẩy về trang đăng nhập
            return "redirect:/admin/login";
        }
        // Nếu có session nhân viên, cho phép truy cập vào trang DiscountPeriod
        model.addAttribute("view","/views/DiscountPeriod/tablink.jsp");
        return "layout";
    }

    @GetMapping("BanOff")
    public String BanOff(Model model,HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("nhanvien") == null) {
            // Nếu không có session nhân viên, đẩy về trang đăng nhập
            return "redirect:/admin/login";
        }
        model.addAttribute("view","/views/BanOFF/BanHangOFF.jsp");
        return "layout";
    }
    @GetMapping("activity")
    public String activity(Model model,HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("nhanvien") == null) {
            // Nếu không có session nhân viên, đẩy về trang đăng nhập
            return "redirect:/admin/login";
        }
        model.addAttribute("view","/views/Activity_log/index.jsp");
        return "layout";
    }
    @GetMapping("Order")
    public String Order(Model model,HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("nhanvien") == null) {
            // Nếu không có session nhân viên, đẩy về trang đăng nhập
            return "redirect:/admin/login";
        }
        model.addAttribute("view","/views/Order/Order.jsp");
        return "layout";
    }
    @GetMapping("Vourcher")
    public String Vourcher(Model model,HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("nhanvien") == null) {
            // Nếu không có session nhân viên, đẩy về trang đăng nhập
            return "redirect:/admin/login";
        }
        model.addAttribute("view","/views/Vourcher/Vourcher.jsp");
        return "layout";
    }

    @GetMapping("NhanVien")
    public String Pay(Model model,HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("nhanvien") == null) {
            // Nếu không có session nhân viên, đẩy về trang đăng nhập
            return "redirect:/admin/login";
        }
        model.addAttribute("view","/views/NhanVien/NhanVien.jsp");
        return "layout";
    }
    @GetMapping("demo")
    public String demo(Model model,HttpServletRequest request){
        return "html";
    }

    @GetMapping("login")
    public String login(){
        return "Login/Login";
    }

    @PostMapping("/saveSelectedProducts")
    public ResponseEntity<String> saveSelectedProducts(@RequestBody List<ProductDetail> selectedProductDetails) {
        System.out.printf(selectedProductDetails.get(0).getProduct().getName());
        return new ResponseEntity<>("", HttpStatus.OK);
    }
}
