package com.example.gatn.Controller;

import com.example.gatn.Entity.Employees;
import com.example.gatn.Entity.Voucher;
import com.example.gatn.Service.EmployeesService;
import com.example.gatn.Service.Impl.EmployeesImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

@RestController
@RequestMapping("staff")
public class NhanVienController {
    @Autowired
    private EmployeesService employeesService = new EmployeesImpl();
    @GetMapping("getListNhanVien")
    public ResponseEntity<?> getlist(@RequestParam(name = "page") int page,
                                     @RequestParam(name = "size") int size){
        Pageable pageable = PageRequest.of(page, size);
        Page<Employees> listpage= employeesService.getlist(pageable);
        return new ResponseEntity<>(listpage, HttpStatus.OK);
    }
    @PostMapping("addNhanVien")
    public ResponseEntity<?> add(@RequestBody Employees employees){
        Map<String, String> errors = validateNhanVien(employees);


        if (!errors.isEmpty()) {
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
        // Lấy ngày hôm nay
        LocalDate localDate = LocalDate.now();

        // Ép kiểu LocalDate về Date
        Date date = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        employees.setCreateDate(date);
        employees.setRoles("NhanVien");
        employees.setStatus(0);

        employeesService.add(employees);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
    private Map<String, String> validateNhanVien(Employees employees) {
        Map<String, String> errors = new HashMap<>();

        if (employees.getFullName() == null) {
            errors.put("fullname", " không được để trống");
        }

            if (employees.getDateOfBirth() == null) {
                errors.put("dateOfBirth", "Không được để trống");
            }


        if (employees.getCity() == null) {
            errors.put("city", "không được để trống");
        }

        if (employees.getCountry() == null) {
            errors.put("country", "không đc để trống");
        }

        if (employees.getNameAccount() == null) {
            errors.put("nameAccount", " không được trống");
        }
        if (employees.getProvince() == null) {
            errors.put("province", " không được để trống");
        }
        if (employees.getFullName() == null || employees.getFullName().isEmpty()) {
            errors.put("password", " không được  để trống");
        }else {
            if (employees.getPassword().trim().length()<6 || employees.getPassword().trim().length()>18) {
                errors.put("password", "password phải có từ 6 - 18 kí tự");
            }
        }

        if (employees.getLine() == null) {
            errors.put("Line", " không được  để trống");
        }
        if (employees.getPhoneNumber() == null) {
            errors.put("phoneNumber", " không được  để trống");
        }else {
            if (employees.getPhoneNumber().trim().length()<10 ||!Pattern.matches("(09|03|07|08|05)+\\d{8}", employees.getPhoneNumber())) {
                errors.put("phoneNumber", " sdt sai định dạng ");
            }
        }
        if (employees.getEmail() == null) {
            errors.put("email", " không được  để trống");
        }
        if (!employees.isGender()) {
            errors.put("gender", " Chưa tích");
        }
        return errors;
    }

    @GetMapping("getNhanvienByid/{id}")
    public ResponseEntity<?> getNhanvien(@PathVariable("id") Integer id){
        Employees employees = employeesService.getonebyid(id);
        return new ResponseEntity<>(employees,HttpStatus.OK);
    }
    @PutMapping("update/{id}")
    public ResponseEntity<?> update(@PathVariable("id") Integer id,@RequestBody Employees employees){
        Map<String, String> errors = validateNhanVien(employees);
        if (!errors.isEmpty()) {
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
        Employees employees1 = employeesService.getonebyid(id);
        BeanUtils.copyProperties(employees,employees1);
        employeesService.update(employees1);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("delete/{id}") // Note: Corrected the mapping annotation
    public ResponseEntity<?> delete(@PathVariable("id") Integer id){
        // Kiểm tra xem bản ghi có tồn tại không
        Employees employees = employeesService.getonebyid(id);
        if (employees == null) {
            // Nếu không tìm thấy, trả về mã trạng thái HTTP NOT_FOUND
            return ResponseEntity.notFound().build();
        }
        // Đánh dấu bản ghi đã xóa bằng cách cập nhật trạng thái
        employees.setStatus(1);
        employeesService.update(employees);

        // Trả về mã trạng thái HTTP OK
        return ResponseEntity.ok().build();
    }
}
