package com.example.gatn.Controller;

import com.example.gatn.Entity.Client;
import com.example.gatn.Entity.Voucher;
import com.example.gatn.Repositoris.ClientReponsitory;
import com.example.gatn.Service.EmailService;
import com.example.gatn.Service.Impl.VoucherImpl;
import com.example.gatn.Service.VoucherService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

@RestController
@RequestMapping("admin")
public class VouCherController {
    @Autowired
    private VoucherService voucherService = new VoucherImpl();

    @Autowired
    private ClientReponsitory clientReponsitory ;

    @Autowired
    private EmailService emailService;



    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int MIN_CODE_LENGTH = 10;
    private static final int MAX_CODE_LENGTH = 12;

    private String generateVoucherCode() {
        Random random = new SecureRandom();

        // Chọn độ dài ngẫu nhiên từ MIN_CODE_LENGTH đến MAX_CODE_LENGTH
        int codeLength = random.nextInt(MAX_CODE_LENGTH - MIN_CODE_LENGTH + 1) + MIN_CODE_LENGTH;

        while (true) {
            StringBuilder code = new StringBuilder(codeLength);

            // Tạo mã ngẫu nhiên
            for (int i = 0; i < codeLength; i++) {
                int randomIndex = random.nextInt(CHARACTERS.length());
                code.append(CHARACTERS.charAt(randomIndex));
            }

            // Kiểm tra xem mã voucher đã tồn tại trong DB chưa
            if (voucherService.getVoucherbycode(code.toString())==null) {
                return code.toString();
            }
        }
    }

    @PostMapping("addvoucher")
    public ResponseEntity<?> addvoucher(@RequestBody Voucher voucher){
        Map<String, String> errors = validateVoucher(voucher);


        if (!errors.isEmpty()) {
            return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
        }
        voucher.setCodevoucherchung(generateVoucherCode());
        for (int i = 0; i < voucher.getQuantity(); i++) {
            Voucher voucher1 = new Voucher();
            BeanUtils.copyProperties(voucher,voucher1);
            String voucherCode = generateVoucherCode();
            voucher1.setCode(voucherCode);
            voucher1.setStatus(0);
            voucher1.setQuantity(1);
            voucherService.add(voucher1);
        }

      //  List<String> clientEmails = getAllClientEmails();

        // Gửi mã voucher đến tất cả khách hàng
      //  emailService.sendVoucherToAllClients(clientEmails, voucher);



        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    public List<String> getAllClientEmails() {
        List<Client> clients = clientReponsitory.findAll();
        return clients.stream()
                .map(Client::getEmail)
                .collect(Collectors.toList());
    }

    private Map<String, String> validateVoucher(Voucher voucher) {
        Map<String, String> errors = new HashMap<>();

        if (voucher.getEndDate() == null) {
            errors.put("endDate", "Hạn sử dụng không được trống");
        }else {
            // Chuyển đổi Date thành LocalDate
            LocalDate endDate = voucher.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

            // Bắt đầu từ ngày mai
            LocalDate tomorrow = LocalDate.now().plusDays(1);

            // Kiểm tra ngày kết thúc có ở trước ngày mai hay không
            if (endDate.isBefore(tomorrow)) {
                errors.put("endDate", "Hạn sử dụng phải bắt đầu từ ngày mai trở đi");
            }
        }

            if (voucher.getQuantity() <= 0) {
                errors.put("quantity", "Số lượng không hợp lệ");
            }

            if (voucher.getMenhGia() <= 0) {
                errors.put("menhgia", "Mệnh giá không hợp lệ");
            }

            if (voucher.getDieukienbatdau() <= 0) {
                errors.put("dieukienbatdau", "Hóa đơn tối thiểu không hợp lệ");
            }

            return errors;
        }
        @GetMapping("getvoucherbystatus")
     public ResponseEntity<?> getlistvoucher( @RequestParam(name = "page") int page,
                                              @RequestParam(name = "size") int size){
            Pageable pageable = PageRequest.of(page, size);
            Page<Voucher> listpage= voucherService.getpageall(pageable);
            return new ResponseEntity<>(listpage, HttpStatus.OK);
        }

    @GetMapping("/checkAndUpdateExpiry")
    public ResponseEntity<String> checkAndUpdateExpiry() {
        // Lấy danh sách voucher từ cơ sở dữ liệu
        List<Voucher> voucherList = voucherService.getallvoucher();

        // Lấy ngày hiện tại
        LocalDate currentDate = LocalDate.now();

        // Kiểm tra và cập nhật trạng thái của voucher
        for (Voucher voucher : voucherList) {
                LocalDate expiryDate = voucher.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

            if (currentDate.isAfter(expiryDate)) {
                voucher.setStatus(2); // Đã hết hạn
            }
        }

        // Lưu cập nhật vào cơ sở dữ liệu
        voucherService.saveall(voucherList);

        return ResponseEntity.ok("Cập nhật trạng thái voucher thành công");
    }

    @GetMapping("voucherDetail/{id}")
    public ResponseEntity<?> getvoucherbyid(@PathVariable("id") Integer id){
        try {
            Voucher voucher = voucherService.getonebyid(id);
            System.out.println(voucher);
            return new ResponseEntity<>(voucher, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error retrieving discount period detail: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("updatevoucher/{id}")
    public ResponseEntity<?> updatevoucher(@PathVariable("id") Integer id,@RequestBody Voucher voucher){
        Map<String, String> errorsupdate = validateVoucher(voucher);

        if (!errorsupdate.isEmpty()) {
            return new ResponseEntity<>(errorsupdate, HttpStatus.BAD_REQUEST);
        }
        Voucher voucher1 = voucherService.getonebyid(id);
        BeanUtils.copyProperties(voucher,voucher1);
        voucher1.setStatus(0);
        voucherService.update(voucher1);
        return new ResponseEntity<>(HttpStatus.OK);
    }


    @GetMapping("vouchersearch")
    public ResponseEntity<?> getVouchers(
            @RequestParam(required = false) String searchText,
            @RequestParam(name = "page") int page,
            @RequestParam(name = "size") int size
    ) {
        // Thực hiện tìm kiếm và phân trang
        Pageable pageable = PageRequest.of(page, size);
        Page<Voucher> result = voucherService.search(searchText, pageable);
        return new ResponseEntity<>(result,HttpStatus.OK);
    }

        @GetMapping("getvoucherbystatus/{status}")
        public ResponseEntity<?> getlistbystatus(@PathVariable("status") Integer status,@RequestParam(name = "page") int page,
                                                 @RequestParam(name = "size") int size){
            Pageable pageable = PageRequest.of(page, size);
            Page<Voucher> listbystatus = voucherService.getVoucherByStatus(status,pageable);
            return new ResponseEntity<>(listbystatus,HttpStatus.OK);

        }

        @DeleteMapping("deletevoucher/{id}")
     public ResponseEntity<?> delete(@PathVariable("id")Voucher voucher){
         voucherService.delete(voucher);
            return ResponseEntity.ok().build();
        }



}

