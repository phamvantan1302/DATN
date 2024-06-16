package com.example.gatn.Controller;

import com.example.gatn.Entity.*;
import com.example.gatn.Service.*;
import com.example.gatn.Service.Impl.*;
import com.example.gatn.ViewModel.Orderrequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Pattern;

@RestController
@RequestMapping("staff")
public class OrderController {
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
    private  VoucherDetailOrderService voucherDetailOrderService = new VoucherDetailOrderImpl();

    @Autowired
    private  VoucherService voucherService = new VoucherImpl();

    @GetMapping("Order")
    public ResponseEntity<?> getOrdersByPageAndStatus(@RequestParam(value = "page", defaultValue = "0") int page,
                                                      @RequestParam(value = "size", defaultValue = "6") int size,
                                                      @RequestParam(value = "status", required = false) Integer status) {
        Page<Order> orders;
        if (status != null) {
            orders = orderService.getOrdersByStatusAndPage(status, page, size);
        } else {
            orders = orderService.getAllOrders(page, size);
        }
        return ResponseEntity.ok(orders);
    }
    @DeleteMapping("DeleteOrderdetailbyqlorder/{id}")
    public ResponseEntity<?> DeleteOrderDetailbyProduct(@PathVariable("id") Integer id){
        Optional<OrderDetail> orderDetail = orderDetailService.getonebyid(id);
        ProductDetail productDetail = productDetailService.getonebyid(orderDetail.get().getProductDetail().getId());
        productDetail.setQuantity(productDetail.getQuantity()+orderDetail.get().getQuantity());
        Order order = orderService.getOrderById(orderDetail.get().getOrder().getId());
        order.setTongtienhang(order.getTongtienhang()-(orderDetail.get().getProductDetail().getPrice())*orderDetail.get().getQuantity());
        order.setTotalMoney(order.getTongtienhang()+order.getMoneyShip());
        orderService.update(order);
        orderDetailService.deletebyid(id);
        return ResponseEntity.ok().build();
    }
    private boolean isValidPhoneNumber(String phoneNumber) {
        // Kiểm tra xem số điện thoại có đúng định dạng không (10 chữ số)
        if (!Pattern.matches("\\d{10}", phoneNumber)) {
            return false;
        }

        // Kiểm tra đầu số của các nhà mạng (ví dụ: Viettel, Vinaphone, Mobifone)
        if (!Pattern.matches("(09|03|07|08|05)+\\d{8}", phoneNumber)) {
            return false;
        }

        return true;
    }

    @PutMapping("updateOrder/{id}")
    public ResponseEntity<String> updateOrder(@PathVariable("id") Integer id, @RequestBody Orderrequest updatedOrder, HttpServletRequest request) {
        try {
            // In ra các giá trị của updatedOrder để kiểm tra
            System.out.println("Nguoi nhan: " + updatedOrder.getNguoinhan());
            System.out.println("Dia chi: " + updatedOrder.getAddress());
            System.out.println("So dien thoai: " + updatedOrder.getSdtnhanhang());

            Order oldvalue = orderService.getOrderById(id);
            Map<String, String> errors = new HashMap<>();

            // Kiểm tra số điện thoại
            if (updatedOrder.getSdtnhanhang() == null || updatedOrder.getSdtnhanhang().trim().isEmpty()) {
                errors.put("sdtnhanhang", "Số điện thoại không được để trống.");
            } else if (!isValidPhoneNumber(updatedOrder.getSdtnhanhang())) {
                errors.put("sdtnhanhang", "Số điện thoại không hợp lệ.");
            }

            // Nếu có lỗi, trả về danh sách lỗi dưới dạng JSON
            if (!errors.isEmpty()) {
                ObjectMapper objectMapper = new ObjectMapper();
                String errorJson = objectMapper.writeValueAsString(errors);
                return ResponseEntity.badRequest().body(errorJson);
            }
            HttpSession session = request.getSession();
            Object data = session.getAttribute("nhanvien");
            if (data instanceof Employees) {
                Employees Data = (Employees) data;
                ActivityLog activityLog = new ActivityLog();
                activityLog.setStaff(Data);
                activityLog.setOrder(oldvalue);
                Calendar currentDateTime = Calendar.getInstance();
                Date currentDate = currentDateTime.getTime();
                activityLog.setTimestamp(currentDate);
                activityLog.setAction("Update Hóa Đơn");
                if (!oldvalue.getNguoinhan().equals(updatedOrder.getNguoinhan())) {
                    activityLog.setDetails(oldvalue.getNguoinhan()+"->" +updatedOrder.getNguoinhan());
                    System.out.println("aaaaaaaaaaaaaaaa23481");
                }
                if (!oldvalue.getAddress().equals(updatedOrder.getAddress())) {
                    activityLog.setDetails(activityLog.getDetails()+";\n"+oldvalue.getAddress()+"->" +updatedOrder.getAddress());
                }
                if (!oldvalue.getSdtnhanhang().equals(updatedOrder.getSdtnhanhang())) {
                    activityLog.setDetails(activityLog.getDetails() + ";\n" + oldvalue.getSdtnhanhang() + "->" + updatedOrder.getSdtnhanhang());
                }
                activity_logService.add(activityLog);
            }


            // Thiết lập các thuộc tính từ updatedOrder sang oldvalue
            oldvalue.setNguoinhan(updatedOrder.getNguoinhan());
            oldvalue.setAddress(updatedOrder.getAddress());
            oldvalue.setSdtnhanhang(updatedOrder.getSdtnhanhang());
            orderService.update(oldvalue);






            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating order: " + e.getMessage());
        }
    }

    @DeleteMapping("deleteorder/{id}")
    public ResponseEntity<?> deleteorder(@PathVariable("id") Integer id,HttpServletRequest request){
        try {
            // Kiểm tra xem đơn hàng có tồn tại không
            Order order = orderService.getOrderById(id);
            if (order == null) {
                return ResponseEntity.notFound().build();
            }

            // Lấy tất cả các chi tiết đơn hàng của đơn hàng này
            List<OrderDetail> listOrderDetail = orderDetailService.getallbyOrder(order);
            for (OrderDetail orderDetail : listOrderDetail) {
                // Lấy thông tin chi tiết sản phẩm để cập nhật lượng tồn kho
                ProductDetail productDetail = orderDetail.getProductDetail();
                productDetail.setQuantity(productDetail.getQuantity() + orderDetail.getQuantity());

                // Xóa chi tiết đơn hàng
                orderDetailService.delete(orderDetail);
            }
            order.setStatus(8);
            orderService.update(order);

            HttpSession session = request.getSession();
            Object data = session.getAttribute("nhanvien");
            if (data instanceof Employees) {
                Employees Data = (Employees) data;
                ActivityLog activityLog = new ActivityLog();
                activityLog.setStaff(Data);
                activityLog.setOrder(order);
                Calendar currentDateTime = Calendar.getInstance();
                Date currentDate = currentDateTime.getTime();
                activityLog.setTimestamp(currentDate);
                activityLog.setAction("Hủy Hóa Đơn");
                activity_logService.add(activityLog);
            }
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            // Xử lý ngoại lệ
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while deleting order: " + e.getMessage());
        }
    }

    @PutMapping("/updatesoluongorder/{id}")
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
    @GetMapping("listProdyctByOrder1/{id}")
    public ResponseEntity<?> getProductByOrder(@PathVariable("id") Order order){
        List<OrderDetail> getallbyOrder = orderDetailService.getallbyOrder(order);
        if (getallbyOrder .isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND); // Trả về 404 nếu không tìm thấy dữ liệu
        }
        double totalmoney1 = 0;
        if(getallbyOrder.isEmpty() || getallbyOrder == null){
            totalmoney1 = 0;
        }
        for (int i = 0; i < getallbyOrder.size(); i++) {
            System.out.println(getallbyOrder.get(i).getPrice());
            System.out.println(getallbyOrder.get(i).getQuantity());
            totalmoney1 += getallbyOrder.get(i).getPrice();
        }
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String todayAsString = today.format(formatter);
        List<DiscountPeriod> getdiscountbetweenstardatandendate = discountPeriodService.getDiscountPeriodsByStartDateBeforeAndEndDateAfter(todayAsString,totalmoney1);
        if (getdiscountbetweenstardatandendate.size()>0){
            // Sắp xếp danh sách theo giá trị giảm dần
            getdiscountbetweenstardatandendate.sort(Comparator.comparingDouble(DiscountPeriod::getValue).reversed());

            int index = 0;
            DiscountDetailOrder discountDetailOrder = new DiscountDetailOrder();
            Double totalmoney = totalmoney1;
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
                discountDetailOrder.setOrder(order);
                discountOrderDetailSevice.add(discountDetailOrder);
                largestDiscountPeriod.setQuantity( largestDiscountPeriod.getQuantity()-1);
                discountPeriodService.update(largestDiscountPeriod);

                // Áp dụng chiết khấu cho đơn hàng
                if (largestDiscountPeriod.getGiamToiDa() < (order.getTongtienhang() - (totalMoney - (totalMoney * (largestDiscountPeriod.getValue() / 100))))) {
                    order.setChietkhau(largestDiscountPeriod.getGiamToiDa());
                } else {
                    order.setChietkhau(totalmoney - (totalMoney - (totalMoney * (largestDiscountPeriod.getValue() / 100))));
                }

                // Cập nhật thông tin đơn hàng
                largestDiscountPeriod.setTonggiatritckmdagiam(largestDiscountPeriod.getTonggiatritckmdagiam() + order.getChietkhau());
                discountPeriodService.update(largestDiscountPeriod);
                order.setTotalMoney(totalMoney);
                order.setTongtienhang(totalMoney - (totalMoney * (largestDiscountPeriod.getValue() / 100)) + order.getMoneyShip());
                orderService.update(order);

              // Đã áp dụng chiết khấu, thoát vòng lặp
                break;
            } while (++index < getdiscountbetweenstardatandendate.size());
            Double tongkm = 0.0;
            List<VoucherDetail> voucherDetailList = voucherDetailOrderService.listvoucherdetailbyorder(order);
            for (int i = 0; i < voucherDetailList.size(); i++) {
                Voucher voucher = voucherDetailList.get(i).getVoucher();
                if (voucher.getDieukienbatdau()<order.getTotalMoney()){
                    tongkm+=voucherDetailList.get(i).getMenhgia();
                }
            }
            Order order2 = orderService.getOrderById(order.getId());
            order2.setChietkhau(order2.getChietkhau()+tongkm);
            System.out.println(tongkm);
            System.out.println("---9");
            order2.setTongtienhang(order2.getTongtienhang()-order2.getChietkhau());
            orderService.update(order2);

            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }else {
            List<DiscountDetailOrder> list = discountOrderDetailSevice.getdistcountbyorder(order);
            Set<Integer> processedDiscountPeriodIds = new HashSet<>();
            for (DiscountDetailOrder discountDetailOrder : list) {
                Integer discountPeriodId = discountDetailOrder.getDiscountPeriod().getId();

                // Kiểm tra xem discountPeriodId đã được xử lý chưa
                if (!processedDiscountPeriodIds.contains(discountPeriodId)) {
                    DiscountPeriod discountPeriod = discountPeriodService.getonebyid(discountPeriodId);

                    // Thực hiện chỉ khi discountPeriod không null
                    if (discountPeriod != null) {
                        discountPeriod.setQuantity(discountPeriod.getQuantity() + 1);
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
            order.setTotalMoney(order.getTotalMoney());
            order.setTongtienhang(order.getTotalMoney()+order.getMoneyShip());
            order.setChietkhau(0);
            orderService.update(order);
            Double tongkm = 0.0;
            List<VoucherDetail> voucherDetailList = voucherDetailOrderService.listvoucherdetailbyorder(order);
            for (int i = 0; i < voucherDetailList.size(); i++) {
                Voucher voucher = voucherDetailList.get(i).getVoucher();
                if (voucher.getDieukienbatdau()<order.getTotalMoney()){
                    tongkm+=voucherDetailList.get(i).getMenhgia();
                }
            }
            Order order2 = orderService.getOrderById(order.getId());
            order2.setChietkhau(order2.getChietkhau()+tongkm);
            System.out.println(tongkm);
            System.out.println("---9");
            order2.setTongtienhang(order2.getTongtienhang()-order2.getChietkhau());
            orderService.update(order2);
        }
        Order order1 = orderService.getOrderById(order.getId());
        order1.setTotalMoney(totalmoney1);
        order1.setTongtienhang(totalmoney1+order1.getMoneyShip()-order1.getChietkhau());
        orderService.update(order1);


        return new ResponseEntity<>(getallbyOrder , HttpStatus.OK);
    }

}
