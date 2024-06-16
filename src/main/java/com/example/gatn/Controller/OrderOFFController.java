package com.example.gatn.Controller;

import com.example.gatn.Entity.*;
import com.example.gatn.Service.*;
import com.example.gatn.Service.Impl.*;
import com.example.gatn.ViewModel.BarcodeView;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.xhtmlrenderer.pdf.ITextRenderer;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

@RestController
@RequestMapping("staff")
public class OrderOFFController {

    @Autowired
    private Activity_logService activity_logService = new Activity_logImpl();

    @Autowired
    private OrderService orderService = new OrderImpl();

    @Autowired
    private OrderDetailService orderDetailService = new OrderDetailImpl();

    @Autowired
    private ProductDetailService productDetailService = new ProductDetailImpl();

    @Autowired
    private DiscountPeriodService discountPeriodService = new DiscountPeriodImpl();

    @Autowired
            private DiscountOrderDetailSevice discountOrderDetailSevice = new DiscountDetailOrderImpl();

    @Autowired
            private DiscountDetailProductSevice discountDetailProductSevice = new DiscountProductDetailImpl();

    @Autowired
            private VoucherService voucherService = new VoucherImpl();

    @Autowired
            private VoucherDetailOrderService voucherDetailOrderService = new VoucherDetailOrderImpl();

    List<Order> listorder = new ArrayList<>();


    @GetMapping("OrDerOff")
    public ResponseEntity<?> addorder(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        Order order = new Order();
        if (session != null && session.getAttribute("nhanvien") != null) {
            // Lấy thông tin nhân viên từ attribute "nhanvien"
            Employees loggedInEmployee = (Employees) session.getAttribute("nhanvien");
            order.setEmployees(loggedInEmployee);

        }

        listorder = orderService.getall();
        System.out.println(listorder.size());
        if (listorder == null || listorder.isEmpty()){
            order.setCode("HD1");
        }else if (listorder.size()>0){
            boolean isCodeExist = true;
            int index = 0;
            while (isCodeExist) {
                String newCode = "HD" + (listorder.size() + index);
                // Kiểm tra xem mã mới đã tồn tại trong danh sách hay chưa
                isCodeExist = false;
                for (int i = 0; i < listorder.size(); i++) {
                    if (newCode.equals(listorder.get(i).getCode())) {
                        isCodeExist = true;
                        break;
                    }
                }
                if (!isCodeExist) {
                    // Nếu mã mới không tồn tại trong danh sách, gán nó cho đơn hàng và thoát khỏi vòng lặp
                    order.setCode(newCode);
                } else {
                    // Nếu mã mới đã tồn tại trong danh sách, tăng chỉ số để tạo mã mới
                    index++;
                }
            }

        }
        LocalDate localDate = LocalDate.now();
        Date date = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
        order.setCreateDate(date);
        order.setStatus(4);
        orderService.add(order);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("Order/{status}")
    public ResponseEntity<?> getallbystatus(@PathVariable("status") Integer status){
        List<Order> listorderbystatus= orderService.getallbystatus(status);
        return ResponseEntity.ok(listorderbystatus);
    }

    @DeleteMapping("DeleteOrder/{id}")
    public ResponseEntity<?> delete(@PathVariable("id") Integer id){
        Order order = orderService.getOrderById(id);
        List<OrderDetail> getlistbyorder = orderDetailService.getallbyOrder(order);
        for (int i = 0; i < getlistbyorder.size(); i++) {
            orderDetailService.delete(getlistbyorder.get(i));
            ProductDetail productDetail = productDetailService.getonebyid(getlistbyorder.get(i).getProductDetail().getId());
            productDetail.setQuantity(productDetail.getQuantity()+getlistbyorder.get(i).getQuantity());
        }
        orderService.delete(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/oneOrder/{id}")
    public ResponseEntity<?> getOrderById(@PathVariable("id") Integer id) {
        Order order = orderService.getOrderById(id);
        if (order != null) {
            return new ResponseEntity<>(order, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Order not found", HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("listProdyctByOrder/{id}")
    public ResponseEntity<?> getProductByOrder(@PathVariable("id") Order order){
        List<OrderDetail> getallbyOrder = orderDetailService.getallbyOrder(order);
        if (getallbyOrder .isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND); // Trả về 404 nếu không tìm thấy dữ liệu
        }
        double totalmoney = 0;
        if(getallbyOrder.isEmpty() || getallbyOrder == null){
            totalmoney = 0;
        }
        for (int i = 0; i < getallbyOrder.size(); i++) {
           totalmoney += getallbyOrder.get(i).getPrice();
        }

        Order order1 = orderService.getOrderById(order.getId());
        order1.setTotalMoney(totalmoney);
        order1.setTongtienhang(totalmoney+order1.getMoneyShip()-order1.getChietkhau());
        orderService.update(order1);
        return new ResponseEntity<>(getallbyOrder , HttpStatus.OK);
    }
    @PostMapping("/scan-barcode")
    public ResponseEntity<?> scanBarcode(@RequestBody BarcodeView barcodeRequest) {
        try {
            // Lấy mã vạch từ yêu cầu
            String barcodeResult = barcodeRequest.getImage();
            ProductDetail productDetail = productDetailService.getonebybarcode(barcodeResult);
            Order order = orderService.getOrderById(barcodeRequest.getId());
            OrderDetail orderDetail = orderDetailService.getorderbyProductDetailandOrder(order,productDetail);
            if (orderDetail == null){
                OrderDetail orderDetail1 = new OrderDetail();
                orderDetail1.setOrder(order);
                orderDetail1.setProductDetail(productDetail);
                orderDetail1.setQuantity(1);
                productDetail.setQuantity(productDetail.getQuantity()-1);
                productDetailService.update(productDetail);
                orderDetail1.setPrice(productDetail.getPrice()*orderDetail1.getQuantity());
                orderDetailService.add(orderDetail1);
                return ResponseEntity.ok(HttpStatus.CREATED);
            }else {
                orderDetail.setQuantity(orderDetail.getQuantity()+1);
                productDetail.setQuantity(productDetail.getQuantity()-1);
                productDetailService.update(productDetail);
                orderDetail.setPrice(productDetail.getPrice()*orderDetail.getQuantity());
                orderDetailService.Update(orderDetail);
                return ResponseEntity.ok(HttpStatus.OK);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Error processing barcode.");
        }
    }

    @DeleteMapping("DeleteOrderdetail/{id}")
    public ResponseEntity<?> DeleteOrderDetailbyProduct(@PathVariable("id") Integer id){
        Optional<OrderDetail> orderDetail = orderDetailService.getonebyid(id);
        ProductDetail productDetail = productDetailService.getonebyid(orderDetail.get().getProductDetail().getId());
        productDetail.setQuantity(productDetail.getQuantity()+orderDetail.get().getQuantity());
        Order order = orderService.getOrderById(orderDetail.get().getOrder().getId());
        order.setTongtienhang(order.getTongtienhang()-(orderDetail.get().getProductDetail().getPrice())*orderDetail.get().getQuantity());
        order.setTotalMoney(order.getTongtienhang());
        orderService.update(order);
        orderDetailService.deletebyid(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping("UpdateOrderdetail/{id}")
    public ResponseEntity<?> UpdayeOrder(@RequestBody Order order,@PathVariable("id") Integer id){
        Map<String, String> errors = new HashMap<>();
        // Kiểm tra số điện thoại
        List<OrderDetail> orderDetails = orderDetailService.getallbyOrder(order);
        if (orderDetails == null || orderDetails.isEmpty()){
            errors.put("orderdetails", "Bạn chưa add sản phẩm ");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }
        if (order.getPhoneNumber() == null){
            errors.put("phonenumber", "Hãy Nhập sdt");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }
        if (!order.getPhoneNumber().matches("\\d+") || order.getPhoneNumber().length() != 10) {
            errors.put("phonenumber", "Hãy Nhập sdt đúng định dạng");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }
        // Kiểm tra xem có lỗi không
        if (!errors.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
        }
            LocalDate today = LocalDate.now();
            // Chuyển đổi LocalDate thành String
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String todayAsString = today.format(formatter);
            List<DiscountPeriod> getdiscountbetweenstardatandendate = discountPeriodService.getDiscountPeriodsByStartDateBeforeAndEndDateAfter(todayAsString,order.getTotalMoney());
        System.out.println("lol");
        System.out.println(getdiscountbetweenstardatandendate.size());
            Order order1 = orderService.getOrderById(id);
            BeanUtils.copyProperties(order,order1);
            if (order.getAddress()!=null)
            {
                order1.setMoneyShip(50000);
            }
        if (order.getAddress()==null){
            order1.setMoneyShip(0);
            order1.setHinhthucthanhtoan(0);
        }
        String address = order.getAddress();
        if (address != null && address.trim().isEmpty()) {
            order1.setMoneyShip(0);
            order1.setHinhthucthanhtoan(0);
        }
        System.out.println("aaaaaaaaaaaaaaph7887");
        System.out.println(order.getTotalMoney());



        orderService.update(order1);
            int dem = 0;
            for (int i = 0; i < getdiscountbetweenstardatandendate.size(); i++) {
                if (getdiscountbetweenstardatandendate.get(i).getApDungCTKMKhac() ==true){
                    dem++;
                }
            }
            if (dem>1){
                System.out.println(dem);
                System.out.println("aaaaaaaaaaaaaaaaa");
                for (int i = 0; i < getdiscountbetweenstardatandendate.size(); i++) {
                        if (getdiscountbetweenstardatandendate.get(i).getCategory()==1 && getdiscountbetweenstardatandendate.get(i).getApDungCTKMKhac() ==true){
                            System.out.println("bbbbbbbbbbbb");
                           List<DiscountDetailProduct> discountDetailProductList = discountDetailProductSevice.getallfindiscount(getdiscountbetweenstardatandendate.get(i));
                            for (int j = 0; j < discountDetailProductList.size(); j++) {
                                DiscountDetailOrder discountDetailOrder = new DiscountDetailOrder();
                                discountDetailOrder.setDiscountPeriod(getdiscountbetweenstardatandendate.get(i));
                                discountDetailOrder.setOrder(order1);
                                discountDetailOrder.setSoluongsp(discountDetailProductList.get(j).getSoLuong());
                                discountDetailOrder.setProductDetail(discountDetailProductList.get(j).getProductDetail());
                                ProductDetail productDetail = discountDetailProductList.get(j).getProductDetail();
                                productDetail.setQuantity(productDetail.getQuantity()-discountDetailProductList.get(j).getSoLuong());
                                discountOrderDetailSevice.add(discountDetailOrder);
                                productDetailService.update(productDetail);
                            }
                            getdiscountbetweenstardatandendate.get(i).setQuantity( getdiscountbetweenstardatandendate.get(i).getQuantity()-1);
                            discountPeriodService.update(getdiscountbetweenstardatandendate.get(i));
                        }
                        if (getdiscountbetweenstardatandendate.get(i).getCategory()==0 && getdiscountbetweenstardatandendate.get(i).getApDungCTKMKhac() ==true){
                            System.out.println("0000000000000");
                            DiscountDetailOrder discountDetailOrder1 = new DiscountDetailOrder();
                            discountDetailOrder1.setDiscountPeriod(getdiscountbetweenstardatandendate.get(i));
                            discountDetailOrder1.setOrder(order1);
                            discountOrderDetailSevice.add(discountDetailOrder1);
                            getdiscountbetweenstardatandendate.get(i).setQuantity( getdiscountbetweenstardatandendate.get(i).getQuantity()-1);
                            discountPeriodService.update(getdiscountbetweenstardatandendate.get(i));
                            Double totalmoney = order.getTotalMoney();
                            int totalMoney = totalmoney.intValue();
                            order1.setTotalMoney(totalMoney-(totalMoney*(getdiscountbetweenstardatandendate.get(i).getValue()/100))+order1.getMoneyShip());
                            order1.setChietkhau(order1.getTongtienhang()-(totalMoney-(totalMoney*(getdiscountbetweenstardatandendate.get(i).getValue()/100))));
                            orderService.update(order1);


                    }
                }
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            if (getdiscountbetweenstardatandendate.size()>0){
                    // Sắp xếp danh sách theo giá trị giảm dần
                    getdiscountbetweenstardatandendate.sort(Comparator.comparingDouble(DiscountPeriod::getValue).reversed());

                    int index = 0;
                    DiscountDetailOrder discountDetailOrder = new DiscountDetailOrder();
                    Double totalmoney = order.getTotalMoney();
                    int totalMoney = totalmoney.intValue();
                    DiscountPeriod largestDiscountPeriod = null;

                    do {
                        largestDiscountPeriod = getdiscountbetweenstardatandendate.get(index);

                        if ((largestDiscountPeriod.getTonggiatritckmdagiam() + (totalMoney * (largestDiscountPeriod.getValue() / 100))) > largestDiscountPeriod.getTonggiatritckm()) {
                            // Không áp dụng được chiết khấu, tăng index và tiếp tục vòng lặp
                            index++;
                            continue;
                        }
                        discountDetailOrder.setDiscountPeriod(largestDiscountPeriod);
                        discountDetailOrder.setOrder(order1);
                        discountOrderDetailSevice.add(discountDetailOrder);
                        largestDiscountPeriod.setQuantity( largestDiscountPeriod.getQuantity()-1);
                        discountPeriodService.update(largestDiscountPeriod);

                        // Áp dụng chiết khấu cho đơn hàng
                        if (largestDiscountPeriod.getGiamToiDa() < (order1.getTongtienhang() - (totalMoney - (totalMoney * (largestDiscountPeriod.getValue() / 100))))) {
                            order1.setChietkhau(largestDiscountPeriod.getGiamToiDa());
                        } else {
                            order1.setChietkhau(order1.getTongtienhang() - (totalMoney - (totalMoney * (largestDiscountPeriod.getValue() / 100))));
                        }

                        // Cập nhật thông tin đơn hàng
                        largestDiscountPeriod.setTonggiatritckmdagiam(largestDiscountPeriod.getTonggiatritckmdagiam() + order1.getChietkhau());
                        discountPeriodService.update(largestDiscountPeriod);
                        order1.setTotalMoney(totalMoney);
                        order1.setTongtienhang(totalMoney - (totalMoney * (largestDiscountPeriod.getValue() / 100)) + order1.getMoneyShip());
                        orderService.update(order1);


                        break;
                    } while (++index < getdiscountbetweenstardatandendate.size());

                    return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            }
                Double totalmoney = order.getTotalMoney();

                int totalMoney = totalmoney.intValue();
                order1.setTotalMoney(totalMoney);
                order1.setTongtienhang(order1.getTongtienhang()+order1.getMoneyShip());
                orderService.update(order1);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);


    }

    @GetMapping("listproductOrder/{id}")
    public ResponseEntity<?> getlistproductorder(@PathVariable("id") Order order){
       List<OrderDetail> listorderdetail= orderDetailService.getallbyOrder(order);
        return new ResponseEntity<>(listorderdetail , HttpStatus.OK);
    }

    @GetMapping("listproductdetail")
    public ResponseEntity<?> getlistproduct(
            @RequestParam(name = "page") int page,
            @RequestParam(name = "size") int size
    ) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ProductDetail> listproductdetail = productDetailService.getProductDetails(pageable);
        System.out.println(listproductdetail.getTotalElements());
        return new ResponseEntity<>(listproductdetail, HttpStatus.OK);
    }

    @PostMapping("addSanPham")
    public ResponseEntity<?> addSanPhamandSoluong(@RequestParam("Idproductdetail") Integer idproductdetail,
                                                  @RequestParam("idorder") Integer idorder,
                                                  @RequestParam("quantity")Integer quantity) {
        ProductDetail productDetail = productDetailService.getonebyid(idproductdetail);
        Order order = orderService.getOrderById(idorder);
        Map<String, Object> response = new HashMap<>();
        if (quantity>productDetail.getQuantity()){
            response.put("status", "error");
            response.put("message", "Sản Phẩm Này Còn :"+productDetail.getQuantity()+"Sản Phẩm");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);

        }
        // Giảm số lượng sản phẩm
        productDetail.setQuantity(productDetail.getQuantity() - quantity);
        productDetailService.update(productDetail);

        // Tạo và lưu chi tiết đơn hàng
        OrderDetail orderDetail = orderDetailService.getorderbyProductDetailandOrder(order,productDetail);
        if (orderDetail == null){
            OrderDetail orderDetail1 = new OrderDetail();
            orderDetail1.setProductDetail(productDetail);
            orderDetail1.setQuantity(quantity);
            orderDetail1.setOrder(order);
            orderDetail1.setPrice1(productDetail.getPrice());
            orderDetail1.setPrice(productDetail.getPrice()*orderDetail1.getQuantity());
            orderDetailService.add(orderDetail1);
            return new ResponseEntity<>(HttpStatus.CREATED);
        }else {
            orderDetail.setQuantity(orderDetail.getQuantity() + quantity);
            orderDetail.setPrice(productDetail.getPrice()*orderDetail.getQuantity());
            orderDetailService.Update(orderDetail);
            return new ResponseEntity<>(HttpStatus.OK);
        }
    }

    @GetMapping("GetDiscount/{id}")
    public ResponseEntity<?> getdiscountbyorder(@PathVariable("id") Order order){
        List<DiscountDetailOrder> discountDetailOrders = discountOrderDetailSevice.getdistcountbyorder(order);
         return new ResponseEntity<>(discountDetailOrders,HttpStatus.OK);
    }

    @GetMapping("Getdiscountdetailproduct/{id}")
    public ResponseEntity<?> getdiscountproductbyorder(@PathVariable("id") Order order){
        List<DiscountDetailOrder> discountDetailOrders = discountOrderDetailSevice.getdistcountbyorder(order);
        List<DiscountDetailProduct> discountDetailProductList = new ArrayList<>();
        for (int i = 0; i < discountDetailOrders.size(); i++) {
            DiscountPeriod discountPeriod = discountPeriodService.getonebyid(discountDetailOrders.get(i).getDiscountPeriod().getId());
            if (discountPeriod.getCategory()==1){
                discountDetailProductList= discountDetailProductSevice.getallfindiscount(discountPeriod);

            }
        }
        return new ResponseEntity<>(discountDetailProductList ,HttpStatus.OK);
    }

    @DeleteMapping("deleteTCKMandvoucherbyorder/{id}")
    public ResponseEntity<?> deleteTCKMandvoucher(@PathVariable("id") Order order){
        List<DiscountDetailOrder> list = discountOrderDetailSevice.getdistcountbyorder(order);
        List<VoucherDetail> listvoucherdetail = voucherDetailOrderService.listvoucherdetailbyorder(order);
        System.out.println(listvoucherdetail.size());
        Set<Integer> processedDiscountPeriodIds = new HashSet<>();

        for (DiscountDetailOrder discountDetailOrder : list) {
            Integer discountPeriodId = discountDetailOrder.getDiscountPeriod().getId();

            // Kiểm tra xem discountPeriodId đã được xử lý chưa
            if (!processedDiscountPeriodIds.contains(discountPeriodId)) {
                DiscountPeriod discountPeriod = discountPeriodService.getonebyid(discountPeriodId);

                // Thực hiện chỉ khi discountPeriod không null
                if (discountPeriod != null) {
                    discountPeriod.setQuantity(discountPeriod.getQuantity() + 1);
                    System.out.println("lop1");
                    discountPeriod.setTonggiatritckmdagiam(discountPeriod.getTonggiatritckmdagiam()-order.getChietkhau());
                    discountPeriodService.update(discountPeriod);

                    // Đánh dấu discountPeriodId đã được xử lý
                    processedDiscountPeriodIds.add(discountPeriodId);
                }
            }
        }
        List<DiscountDetailOrder> list1 = discountOrderDetailSevice.getdistcountbyorder(order);
        for (int i = 0; i < list1.size(); i++) {
            discountOrderDetailSevice.delete(list1.get(i));
        }
        for (int i = 0; i < listvoucherdetail.size(); i++) {
            Voucher voucher = voucherService.getonebyid(listvoucherdetail.get(i).getVoucher().getId());
            voucher.setQuantity(voucher.getQuantity()+listvoucherdetail.get(i).getSoluong());
            voucher.setStatus(0);
            voucherService.update(voucher);
            voucherDetailOrderService.delete(listvoucherdetail.get(i));
        }
        order.setTotalMoney(order.getTotalMoney());
        order.setTongtienhang(order.getTotalMoney());
        order.setChietkhau(0);
        order.setMoneyShip(0);
        orderService.update(order);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/addvoucher")
    public ResponseEntity<?> addVoucherToOrder(@RequestBody Map<String, Object> request) {
        try {
            String voucherCode = (String) request.get("voucherCode");
            Map<String, Object> orderMap = (Map<String, Object>) request.get("order");

            // Convert orderMap thành đối tượng Order
            ObjectMapper objectMapper = new ObjectMapper();
            Order orderObject = objectMapper.convertValue(orderMap, Order.class);

            // Trả về đối tượng JSON (ví dụ: Map<String, Object>)
            Map<String, Object> response = new HashMap<>();
            // Kiểm tra xem voucherCode có tồn tại không
            Voucher voucher = voucherService.getVoucherbycode(voucherCode);
            if (voucher == null) {
                Map<String, String> errors = new HashMap<>();
                errors.put("voucher", "Voucher does not exist");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errors);
            }
            if (voucher.getDieukienbatdau()>orderObject.getTotalMoney()){
                response.put("status", "error");
                response.put("message", "Hóa đơn phải >" +voucher.getDieukienbatdau()+" để sử dụng voucher này");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
            Date currentDate = new Date();
            if (voucher.getEndDate().before(currentDate)){
                response.put("status", "error");
                response.put("message", "Voucher này đã hết hạn sử dụng");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
            List<VoucherDetail> listvoucherdetail = voucherDetailOrderService.listvoucherdetailbyorder(orderObject);
            for (int i = 0; i < listvoucherdetail.size(); i++) {
                if (listvoucherdetail.get(i).getVoucher().getCodevoucherchung().equals(voucher.getCodevoucherchung())){
                    response.put("status", "error");
                    response.put("message", "Bạn đã sử dụng loại voucher này");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
                }

            }
            VoucherDetail voucherDetail1 = voucherDetailOrderService.getvoucherdetailbyorderandvoucher(orderObject,voucher);
            if (voucher.getQuantity()>0){
                if (voucherDetail1==null ){
                    VoucherDetail voucherDetail = new VoucherDetail();
                    voucher.setQuantity(voucher.getQuantity()-1);
                    voucher.setStatus(1);
                    voucher.setNgaysudung(currentDate);
                    voucherDetail.setVoucher(voucher);
                    voucherDetail.setSoluong(1);
                    voucherDetail.setMenhgia(voucher.getMenhGia());
                    voucherDetail.setOrder(orderObject);
                    orderObject.setTongtienhang(orderObject.getTongtienhang()-voucher.getMenhGia());
                    orderObject.setChietkhau(orderObject.getChietkhau()+voucher.getMenhGia());
                    voucherService.update(voucher);
                    voucherDetailOrderService.add(voucherDetail);
                    orderService.update(orderObject);
                    response.put("status", "success");
                    response.put("message", "Thêm voucher thành công");
                    return ResponseEntity.ok(response);
                }
                    else {
                    response.put("status", "error");
                    response.put("message", "Voucher đã được sử dụng cho hóa đơn này");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
                }
            }else{
                response.put("status", "error");
                response.put("message", "Voucher đã hết số lượng");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
        } catch (Exception e) {
            Map<String, String> errors = new HashMap<>();
            errors.put("internalError", "Internal Server Error");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errors);
        }
    }
    @GetMapping("getvoucherbyorder/{id}")
    public ResponseEntity<?> getvoucherbyorder(@PathVariable("id") Order order){
        List<VoucherDetail> list = voucherDetailOrderService.listvoucherdetailbyorder(order);
        return new ResponseEntity<>(list,HttpStatus.OK);
    }

    @DeleteMapping("Deletevoucherdetail/{id}")
    public ResponseEntity<?> deletevoucher(@PathVariable("id") Order order){
        List<VoucherDetail> listvoucherdetail = voucherDetailOrderService.listvoucherdetailbyorder(order);
        for (int i = 0; i < listvoucherdetail.size(); i++) {
            Voucher voucher = voucherService.getonebyid(listvoucherdetail.get(i).getVoucher().getId());
            voucher.setQuantity(voucher.getQuantity()+listvoucherdetail.get(i).getSoluong());
            voucher.setNgaysudung(null);
            voucher.setStatus(0);
            order.setTongtienhang(order.getTongtienhang()+voucher.getMenhGia());
            order.setChietkhau(order.getChietkhau()-voucher.getMenhGia());
            orderService.update(order);
            voucherService.update(voucher);
            voucherDetailOrderService.delete(listvoucherdetail.get(i));
        }
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("deletevoucherdetailbyid/{id}")
    public ResponseEntity<?> deleteonevoucherdetail(@PathVariable("id") VoucherDetail voucherDetail){
        Order order = orderService.getOrderById(voucherDetail.getOrder().getId());
        Voucher voucher = voucherService.getonebyid(voucherDetail.getVoucher().getId());
        voucher.setQuantity(voucher.getQuantity()+voucherDetail.getSoluong());
        voucher.setNgaysudung(null);
        voucher.setStatus(0);
        order.setChietkhau(order.getChietkhau()-voucher.getMenhGia());
        order.setTongtienhang(order.getTongtienhang()+voucher.getMenhGia());
        orderService.update(order);
        voucherService.update(voucher);
        voucherDetailOrderService.delete(voucherDetail);
        return ResponseEntity.ok().build();
    }
    @GetMapping("startUpdating")
    public void startUpdating() {
        voucherService.updatestatus();
    }

    @PutMapping("updateorder/{id}")
    public ResponseEntity<?> updatestatus(@PathVariable("id") Integer id, @RequestBody Order order,HttpServletRequest request){
        // Lấy đơn hàng cần cập nhật từ cơ sở dữ liệu
        Order existingOrder = orderService.getOrderById(id);
        // Kiểm tra xem đơn hàng tồn tại hay không
        if (existingOrder == null) {
            return ResponseEntity.notFound().build();
        }
        // Kiểm tra xem dữ liệu đơn hàng gửi lên có hợp lệ hay không
        if (order == null) {
            return ResponseEntity.badRequest().build();
        }
        // Lấy hình thức thanh toán mới từ dữ liệu gửi lên
        int hinhThucThanhToan = order.getHinhthucthanhtoan();
        int newStatus = 0;
        // Dựa vào hình thức thanh toán mới, xác định trạng thái mới của đơn hàng
        switch (hinhThucThanhToan) {
            case 0:
                newStatus = 5; // Thanh toán tại quầy
                break;
            case 1:
                newStatus = 6; // Nhận hàng thanh toán
                break;
            case 2:
                newStatus = 7; // Thanh toán trước 50%
                break;
            default:
                // Xử lý trường hợp không hợp lệ nếu cần
                break;
        }
        // Cập nhật trạng thái mới cho đơn hàng
        existingOrder.setHinhthucthanhtoan(hinhThucThanhToan);
        existingOrder.setStatus(newStatus);
        HttpSession session = request.getSession();
        Object data = session.getAttribute("nhanvien");
        if (data instanceof Employees) {
            Employees Data = (Employees) data;
            ActivityLog activityLog = new ActivityLog();
            activityLog.setStaff(Data);
            activityLog.setOrder(existingOrder);
            activityLog.setAction("Thanh Toán");
            Calendar currentDateTime = Calendar.getInstance();
            Date currentDate = currentDateTime.getTime();
            activityLog.setTimestamp(currentDate);
            activity_logService.add(activityLog);
        }
        // Lưu đơn hàng đã được cập nhật vào cơ sở dữ liệu
        orderService.update(existingOrder);
        // Trả về phản hồi OK (200)
        return ResponseEntity.ok().build();

    }
    @GetMapping("/generate-invoice/{id}")
    public ResponseEntity<byte[]> generateInvoice(@PathVariable("id") Order order, Model model) {
        if (order == null) {
            return ResponseEntity.notFound().build();
        }
        try {
            // Đọc mẫu HTML từ tệp
            FileInputStream inputStream = new FileInputStream("C:\\Users\\Admin\\Downloads\\du an\\du an\\GATN_ADIDASSPORST\\src\\main\\webapp\\views\\BanOFF\\demo.jsp");
            byte[] buffer = new byte[inputStream.available()];
            inputStream.read(buffer);
            inputStream.close();
            String htmlContent = new String(buffer, StandardCharsets.UTF_8);
            double totalvoucher = 0;
            List<VoucherDetail> listvoucherdetail = voucherDetailOrderService.listvoucherdetailbyorder(order);
            for (int i = 0; i < listvoucherdetail.size(); i++) {
                totalvoucher+=listvoucherdetail.get(i).getMenhgia();
            }
            // Thay thế các giá trị tương ứng trong mẫu HTML
            htmlContent = htmlContent.replace("{{orderCode}}", order.getCode());
            htmlContent = htmlContent.replace("{{customerName}}", order.getUseName());
            htmlContent = htmlContent.replace("{{ordertongtienhang}}", String.valueOf(order.getTongtienhang()));
            htmlContent = htmlContent.replace("{{ordermoneyShip}}", String.valueOf(order.getMoneyShip()));
            htmlContent = htmlContent.replace("{{ordertotalMoney}}", String.valueOf(order.getTotalMoney()));
            htmlContent = htmlContent.replace("{{orderchietkhau}}", String.valueOf(order.getChietkhau()));
            htmlContent = htmlContent.replace("{{totalVoucher}}", String.valueOf(totalvoucher));
            List<OrderDetail> products = orderDetailService.getallbyOrder(order);
            StringBuilder itemsHtml = new StringBuilder();
            for (OrderDetail product : products) {
                itemsHtml.append("<tr>")
                        .append("<td>").append(product.getProductDetail().getProduct().getName()).append("</td>")
                        .append("<td>").append(product.getQuantity()).append("</td>")
                        .append("<td>").append(product.getPrice()).append("</td>")
                        .append("</tr>");
            }
            // Thay thế placeholder trong HTMLContent với chuỗi HTML danh sách sản phẩm
            htmlContent = htmlContent.replace("{{products}}", itemsHtml.toString());
            // Chuyển đổi HTML thành tệp PDF sử dụng Flying Saucer
            ITextRenderer renderer = new ITextRenderer();
            renderer.setDocumentFromString(htmlContent);
            renderer.layout();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            renderer.createPDF(outputStream);

            // Trả về tệp PDF dưới dạng một mảng byte trong ResponseEntity
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + order.getCode() + ".pdf")
                    .contentType(MediaType.APPLICATION_PDF)
                    .body(outputStream.toByteArray());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build(); // Trả về 400 Bad Request nếu có lỗi xảy ra
        }
    }
    @PutMapping("/updatesoluong/{id}")
    public ResponseEntity<?> updateOrderDetailQuantity(@PathVariable("id") Integer orderDetailId, @RequestBody int newQuantity) {
        try {
            // Lấy thông tin chi tiết đơn hàng từ cơ sở dữ liệu
            Optional<OrderDetail> optionalOrderDetail = orderDetailService.getonebyid(orderDetailId);

            if (!optionalOrderDetail.isPresent()) {
                return ResponseEntity.notFound().build();
            }

            // Lấy ra đối tượng OrderDetail từ Optional
            OrderDetail orderDetail = optionalOrderDetail.get();

            // Lấy thông tin sản phẩm từ chi tiết đơn hàng
            ProductDetail productDetail = orderDetail.getProductDetail();

            // Lấy số lượng hiện tại của sản phẩm
            int currentQuantity = productDetail.getQuantity();

            // Số lượng mới của sản phẩm
            int oldQuantity = orderDetail.getQuantity();

            // Cập nhật số lượng mới của chi tiết đơn hàng
            orderDetail.setPrice(orderDetail.getPrice1() * newQuantity);
            orderDetail.setQuantity(newQuantity);
            orderDetailService.Update(orderDetail);

            // Cập nhật số lượng của sản phẩm trong kho
            int updatedQuantity = currentQuantity + oldQuantity - newQuantity;
            productDetail.setQuantity(updatedQuantity);
            productDetailService.update(productDetail);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while updating order detail quantity: " + e.getMessage());
        }
    }
}


