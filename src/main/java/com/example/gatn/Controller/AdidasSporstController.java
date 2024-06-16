package com.example.gatn.Controller;

import com.example.gatn.Entity.*;
import com.example.gatn.Repositoris.*;
import com.example.gatn.Service.*;
import com.example.gatn.Service.Impl.*;
import com.example.gatn.ViewModel.LoginRequest;
import com.example.gatn.ViewModel.ProductDetailViewModel;
import com.example.gatn.ViewModel.orderdataOnl;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lowagie.text.html.simpleparser.Img;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

@RestController
@RequestMapping("/AdidasSporst")
public class AdidasSporstController {

    @Autowired
    private ProductDetailService productDetailService = new ProductDetailImpl();

    @Autowired
    private ImageRepository imageRepository;

    @Autowired
    private ClientReponsitory clientReponsitory;

    @Autowired
    private ProductDetailReponsitoty productDetailReponsitoty;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private OrderService orderService = new OrderImpl();

    @Autowired
    private OrderDetailService orderDetailService = new OrderDetailImpl();

    @Autowired
    private DiscountPeriodService discountPeriodService = new DiscountPeriodImpl();

    @Autowired
    private DiscountOrderDetailSevice discountOrderDetailSevice = new DiscountDetailOrderImpl();

    @Autowired
    private VoucherService voucherService = new VoucherImpl();


    @Autowired
    private VoucherDetailOrderService voucherDetailOrderService= new VoucherDetailOrderImpl();

    @Autowired
    private SizeRepository sizeRepository;

    @Autowired
    private ColorRepository colorRepository;

    @Autowired
    private OrderDetailReponsitory orderDetailReponsitory;

    @GetMapping("listproductdetail")
    public ResponseEntity<Page<ProductDetailWithImagesDTO>> getlistproduct(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "9") int size
    ) {

        Pageable pageable = PageRequest.of(page, size);
        Page<ProductDetail> listproductdetail = productDetailService.getlistchung(pageable);
        System.out.println("pko");
        System.out.println(listproductdetail.getSize());

        // Tạo danh sách mới chứa thông tin sản phẩm chi tiết cùng với hình ảnh
        List<ProductDetailWithImagesDTO> productDetailsWithImages = new ArrayList<>();
        for (ProductDetail productDetail : listproductdetail.getContent()) {
            // Tạo một đối tượng DTO mới chứa thông tin sản phẩm chi tiết và hình ảnh
            ProductDetailWithImagesDTO detailWithImagesDTO = new ProductDetailWithImagesDTO();
            detailWithImagesDTO.setProductDetail(productDetail);
            // Các thông tin khác của sản phẩm chi tiết

            // Lấy danh sách hình ảnh của sản phẩm chi tiết
            List<String> imageUrls = new ArrayList<>();

            List<Image> listimgbyproductdetail = imageRepository.getByIdSp(productDetail.getId());

            for (Image image : listimgbyproductdetail) {
                // Thêm URL của hình ảnh vào danh sách
                imageUrls.add(image.getName());
            }
            // Đặt danh sách URL hình ảnh vào đối tượng DTO
            detailWithImagesDTO.setImageUrls(imageUrls);

            // Thêm đối tượng DTO vào danh sách kết quả
            productDetailsWithImages.add(detailWithImagesDTO);
        }

        // Tạo một đối tượng Page mới từ danh sách sản phẩm chi tiết kèm hình ảnh
        Page<ProductDetailWithImagesDTO> resultPage = new PageImpl<>(productDetailsWithImages, pageable, listproductdetail.getTotalElements());

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String,String>> login(@RequestBody LoginRequest loginRequest, HttpServletRequest request) {
        // Thực hiện xác thực thông tin đăng nhập
        String username = loginRequest.getUsername();
        String password = loginRequest.getPassword();
        Optional<Client> userOptional = clientReponsitory.getClientByEmailAndPassword(username,password);
        System.out.println(userOptional.get().getId());
        System.out.println("aaaa");
        if (userOptional != null) {
            HttpSession session = request.getSession();
            // Lưu thông tin người dùng vào session
            session.setAttribute("Client", userOptional);
            session.setAttribute("email",username);
            Map<String, String> response = new HashMap<>();
            response.put("redirectUrl", "/AdidasSporst/home");
            return ResponseEntity.ok().body(response);
        } else {
            // Trả về lỗi khi không tìm thấy nhân viên
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Tài khoản không tồn tại");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
        }
    }
    // thêm sp vào giỏ hàng

    @GetMapping("/addToCart/{id}")
    public ResponseEntity<String> addToCart(@PathVariable("id") Integer id, HttpServletRequest request) {
        ProductDetail productDetail = productDetailService.getonebyid(id);
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Cart cart = (Cart) session.getAttribute("cart");
        Client client = clientReponsitory.getClientByEmail(email);
        if (client!= null) {
            Cart cart1 = cartRepository.getCartByClientAndStatus(client,0);
            if (cart1!=null){
                CartDetail cartDetail1 = cartDetailRepository.getCartDetailByCartAndProductDetail(cart1,productDetail);
                if (cartDetail1!=null){
                    cartDetail1.setQuantity(cartDetail1.getQuantity()+1);
                    cartDetailRepository.save(cartDetail1);
                }else {
                    CartDetail cartDetail2= new CartDetail();
                    cartDetail2.setCart(cart1);
                    cartDetail2.setProductDetail(productDetail);
                    cartDetail2.setQuantity(1);
                    cartDetail2.setPrice(productDetail.getPrice());
                    cartDetailRepository.save(cartDetail2);
                }
            }else {
                Cart cart2 = new Cart();
                cart2.setClient(client);
                cart2.setStatus(0);
                cartRepository.save(cart2);
                CartDetail cartDetail3= new CartDetail();
                cartDetail3.setCart(cart2);
                cartDetail3.setProductDetail(productDetail);
                cartDetail3.setQuantity(1);
                cartDetail3.setPrice(productDetail.getPrice());
                cartDetailRepository.save(cartDetail3);
            }
            return ResponseEntity.ok("Product added to cart successfully.");
        }
        if(cart!=null){
            CartDetail cartDetail = cartDetailRepository.getCartDetailByCartAndProductDetail(cart,productDetail);
            if (cartDetail!= null){
                cartDetail.setQuantity(cartDetail.getQuantity()+1);
                cartDetailRepository.save(cartDetail);
            }else {
                CartDetail cartDetail1 = new CartDetail();
                cartDetail1.setCart(cart);
                cartDetail1.setProductDetail(productDetail);
                cartDetail1.setQuantity(1);
                cartDetail1.setPrice(productDetail.getPrice());
                cartDetailRepository.save(cartDetail1);
            }
        }else {
            Cart cart1 = new Cart();
            cart1.setStatus(0);
            cart1.setClient(null);
            cartRepository.save(cart1);
            session.setAttribute("cart",cart1);
            session.setAttribute("IdCart",cart1.getId());
            CartDetail cartDetail = new CartDetail();
            cartDetail.setCart(cart1);
            cartDetail.setProductDetail(productDetail);
            cartDetail.setPrice(productDetail.getPrice());
            cartDetail.setQuantity(1);
            cartDetailRepository.save(cartDetail);
        }
        return ResponseEntity.ok("Product added to cart successfully.");


    }

    @GetMapping("GetCart")
    public ResponseEntity<?> getcart(@RequestParam(name = "page", defaultValue = "0") int page,
                                     @RequestParam(name = "size", defaultValue = "3") int size,  HttpServletRequest request){
        HttpSession session = request.getSession();
        Object client11 = session.getAttribute("Client");
        String email = (String) session.getAttribute("email");
        Client client = clientReponsitory.getClientByEmail(email);

        if (client11!=null){
            Cart cart2 = cartRepository.getCartByClientAndStatus(client,0);
            if (cart2!=null){
                if (page < 0) {
                    page = 0; // hoặc bất kỳ giá trị mặc định nào phù hợp với logic của bạn
                }
                Pageable pageable = PageRequest.of(page, 3); // Ví dụ: phân trang, bạn có thể điều chỉnh theo nhu cầu của mình
                Page<CartDetail> cartDetailPage = cartDetailRepository.getCartDetailsByCart(cart2, pageable);
                return ResponseEntity.ok(cartDetailPage);
            }
        }
        Integer id = (Integer) session.getAttribute("IdCart");
        Optional<Cart> cart= cartRepository.findById(id);
        if (cart!=null ){
            if (page < 0) {
                page = 0; // hoặc bất kỳ giá trị mặc định nào phù hợp với logic của bạn
            }
            Pageable pageable = PageRequest.of(page, size); // Ví dụ: phân trang, bạn có thể điều chỉnh theo nhu cầu của mình
            Page<CartDetail> cartDetailPage = cartDetailRepository.getCartDetailsByCart(cart.get(), pageable);
            return ResponseEntity.ok(cartDetailPage);
        } else {
            Cart cart1 = cartRepository.getCartByClientAndStatus(client,0);
            if (cart1!=null){
                if (page < 0) {
                    page = 0; // hoặc bất kỳ giá trị mặc định nào phù hợp với logic của bạn
                }
                Pageable pageable = PageRequest.of(page, size);
                Page<CartDetail> cartDetailPage = cartDetailRepository.getCartDetailsByCart(cart1,pageable);
                return ResponseEntity.ok(cartDetailPage);
            }
            return ResponseEntity.noContent().build();
        }
    }

    @DeleteMapping("deleteProductCartdetail/{id}")
    public ResponseEntity<?> deleteproductCardetail(@PathVariable("id") Integer id){
        try {
            cartDetailRepository.deleteById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting cart detail: " + e.getMessage());
        }
    }

    @PutMapping("/tangsoluong/{id}")
    public ResponseEntity<?> tangsoluong(@PathVariable Integer id) {
        Optional<CartDetail> optionalCartDetail = cartDetailRepository.findById(id);
        if (optionalCartDetail.isPresent()) {
            CartDetail cartDetail = optionalCartDetail.get();
            cartDetail.setQuantity(cartDetail.getQuantity() + 1);
            cartDetailRepository.save(cartDetail);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/giamsoluong/{id}")
    public ResponseEntity<?> giamsoluong(@PathVariable Integer id) {
        Optional<CartDetail> optionalCartDetail = cartDetailRepository.findById(id);
        if (optionalCartDetail.isPresent()) {
            CartDetail cartDetail = optionalCartDetail.get();
            int newQuantity = cartDetail.getQuantity() - 1;
            if (newQuantity < 1) {
                // Xóa sản phẩm khỏi giỏ hàng nếu số lượng mới là âm hoặc bằng 0
                cartDetailRepository.delete(cartDetail);
                return ResponseEntity.ok().build();
            } else {
                cartDetail.setQuantity(newQuantity);
                cartDetailRepository.save(cartDetail);
                return ResponseEntity.ok().build();
            }
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @GetMapping("checksoluongproductkhitt")
    public ResponseEntity<?> checksl(HttpServletRequest request) {
        List<String> errorMessages = new ArrayList<>();
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Cart cart = (Cart) session.getAttribute("cart");
        Client client = clientReponsitory.getClientByEmail(email);

        if (cart != null) {
            List<CartDetail> cartDetailList = cartDetailRepository.getCartDetailsByCart(cart);
            if (cartDetailList != null) {
                for (CartDetail cartDetail : cartDetailList) {
                    int quantityInCart = cartDetail.getQuantity();
                    int currentQuantity = cartDetail.getProductDetail().getQuantity();
                    if (quantityInCart > currentQuantity) {
                        String errorMessage = "Số lượng sản phẩm " + cartDetail.getProductDetail().getProduct().getName() + " chỉ còn " + currentQuantity;
                        errorMessages.add(errorMessage);
                    }
                }
            }
        } else {
            Cart cart1 = cartRepository.getCartByClientAndStatus(client, 0);
            if (cart1 != null) {
                List<CartDetail> cartDetailList = cartDetailRepository.getCartDetailsByCart(cart);
                if (cartDetailList != null) {
                    for (CartDetail cartDetail : cartDetailList) {
                        int quantityInCart = cartDetail.getQuantity();
                        int currentQuantity = cartDetail.getProductDetail().getQuantity();
                        if (quantityInCart > currentQuantity) {
                            String errorMessage = "Số lượng sản phẩm " + cartDetail.getProductDetail().getProduct().getName() + " chỉ còn " + currentQuantity;
                            errorMessages.add(errorMessage);
                        }
                    }
                }
            }
        }

        if (!errorMessages.isEmpty()) {
            // Trả về thông báo lỗi
            return ResponseEntity.badRequest().body(errorMessages);
        }

        // Trả về phản hồi thành công nếu không có lỗi
        return ResponseEntity.ok().build();
    }

    @GetMapping("checkUser")
    public ResponseEntity<?> checkuse(HttpServletRequest request){
        HttpSession session = request.getSession(); // Lấy session hiện tại, không tạo mới nếu chưa có

        if (session != null && session.getAttribute("Client") != null) {
            // Người dùng đã đăng nhập, có thông tin người dùng trong session
            String email = (String) session.getAttribute("email");
            Client client = clientReponsitory.getClientByEmail(email);
            return ResponseEntity.ok(client);
        } else {
            // Trả về thông báo lỗi khi người dùng chưa đăng nhập
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Bạn cần đăng nhập để sử dụng chức năng này");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
        }
    }

    @GetMapping("Tongtien")
    public ResponseEntity<?> gettongtiencart(HttpServletRequest request){
        HttpSession session = request.getSession();
        Object client11 = session.getAttribute("Client");
        String email = (String) session.getAttribute("email");
        Client client = clientReponsitory.getClientByEmail(email);

        if (client11!=null){
            Cart cart2 = cartRepository.getCartByClientAndStatus(client,0);
            if (cart2!=null){
              List<CartDetail> cartDetail = cartDetailRepository.getCartDetailsByCart(cart2);
                Double totalmoney= 0.0;
                for (int i = 0; i < cartDetail.size(); i++) {
                    totalmoney+= cartDetail.get(i).getPrice()*cartDetail.get(i).getQuantity();
                }
                return ResponseEntity.ok(totalmoney);
            }
        }
        Integer id = (Integer) session.getAttribute("IdCart");
        Optional<Cart> cart= cartRepository.findById(id);
        Cart cart1 = cartRepository.getReferenceById(cart.get().getId());
        if (cart!=null ){
            List<CartDetail> cartDetail = cartDetailRepository.getCartDetailsByCart(cart1);
            Double totalmoney= 0.0;
            for (int i = 0; i < cartDetail.size(); i++) {
                totalmoney+= cartDetail.get(i).getPrice()*cartDetail.get(i).getQuantity();
            }
            return ResponseEntity.ok(totalmoney);
        }
        return ResponseEntity.badRequest().body("Unable to calculate total money.");

    }

    private  Order orderonlnoclient;

    @PostMapping("addOrderNoClien")
    public ResponseEntity<?> addcarttoOrder(@RequestBody orderdataOnl orderData, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        List<Order> listorder = orderService.getall();
        if (cart != null) {
          List<CartDetail> cartDetailList = cartDetailRepository.getCartDetailsByCart(cart);
          if (cartDetailList.size()>0){
              Order order = new Order();
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
              order.setMoneyShip(50000);
              order.setStatus(4);
              order.setSdtnhanhang(orderData.getPhoneNumber());
              order.setPhoneNumber(orderData.getPhoneNumber2());
              order.setAddress(orderData.getAddress()+"/"+orderData.getDistrict()+"/"+orderData.getCity());
              order.setNguoinhan(orderData.getReceiverName());
              orderService.add(order);

              Double totalmoney=0.0;

              for (int i = 0; i < cartDetailList.size() ; i++) {
                  OrderDetail orderDetail = new OrderDetail();
                  ProductDetail productDetail = productDetailService.getonebyid(cartDetailList.get(i).getProductDetail().getId());
                  orderDetail.setOrder(order);
                  orderDetail.setProductDetail(cartDetailList.get(i).getProductDetail());
                  orderDetail.setPrice(cartDetailList.get(i).getPrice());
                  orderDetail.setQuantity(cartDetailList.get(i).getQuantity());
                  productDetail.setQuantity(productDetail.getQuantity()-cartDetailList.get(i).getQuantity());
                  orderDetail.setPrice1(cartDetailList.get(i).getQuantity()*cartDetailList.get(i).getPrice());
                  orderDetailService.add(orderDetail);
                  productDetailService.update(productDetail);
                  totalmoney += cartDetailList.get(i).getPrice()*cartDetailList.get(i).getQuantity();
              }
              order.setTotalMoney(totalmoney);
              orderService.update(order);
              LocalDate today = LocalDate.now();
              DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
              String todayAsString = today.format(formatter);
              List<DiscountPeriod> getdiscountbetweenstardatandendate = discountPeriodService.getDiscountPeriodsByStartDateBeforeAndEndDateAfter(todayAsString,order.getTotalMoney());
              if (getdiscountbetweenstardatandendate.size()>0){
                  // Sắp xếp danh sách theo giá trị giảm dần
                  getdiscountbetweenstardatandendate.sort(Comparator.comparingDouble(DiscountPeriod::getValue).reversed());

                  int index = 0;
                  DiscountDetailOrder discountDetailOrder = new DiscountDetailOrder();
                  Double totalmoney1 = order.getTotalMoney();
                  int totalMoney1 = totalmoney1.intValue();
                  DiscountPeriod largestDiscountPeriod = null;
                  for (int i = 0; i < getdiscountbetweenstardatandendate.size(); i++) {
                      System.out.println(getdiscountbetweenstardatandendate.get(i).getValue());
                      System.out.println(getdiscountbetweenstardatandendate.get(i).getTonggiatritckmdagiam()+(totalMoney1 * (getdiscountbetweenstardatandendate.get(i).getValue() / 100)));
                      System.out.println(getdiscountbetweenstardatandendate.get(i).getTonggiatritckm());
                  }

                  while (index < getdiscountbetweenstardatandendate.size()) {
                      largestDiscountPeriod = getdiscountbetweenstardatandendate.get(index);
                      System.out.println(index);

                      if ((largestDiscountPeriod.getTonggiatritckmdagiam() + (totalMoney1 * (largestDiscountPeriod.getValue() / 100))) > largestDiscountPeriod.getTonggiatritckm()) {
                          index++;
                          continue;
                      }

                      discountDetailOrder.setDiscountPeriod(largestDiscountPeriod);
                      discountDetailOrder.setOrder(order);
                      discountOrderDetailSevice.add(discountDetailOrder);
                      largestDiscountPeriod.setQuantity(largestDiscountPeriod.getQuantity() - 1);
                      discountPeriodService.update(largestDiscountPeriod);

                      // Áp dụng chiết khấu cho đơn hàng
                      if (largestDiscountPeriod.getGiamToiDa() < (order.getTotalMoney() - (totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100))))) {
                          order.setChietkhau(largestDiscountPeriod.getGiamToiDa());
                      } else {
                          order.setChietkhau(order.getTotalMoney() - (totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100))));
                      }

                      // Cập nhật thông tin đơn hàng
                      largestDiscountPeriod.setTonggiatritckmdagiam(largestDiscountPeriod.getTonggiatritckmdagiam() + order.getChietkhau());
                      discountPeriodService.update(largestDiscountPeriod);
                      order.setTotalMoney(totalMoney1);
                      order.setTongtienhang(totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100)) + order.getMoneyShip());
                      orderService.update(order);

                      // Đã áp dụng chiết khấu, thoát vòng lặp
                      break;
                  }
                    this.orderonlnoclient=order;
                  return new ResponseEntity<>(HttpStatus.NO_CONTENT);

              }
              int totalMoney = totalmoney.intValue();
              order.setTotalMoney(totalMoney);
              order.setTongtienhang(order.getTotalMoney()+order.getMoneyShip());
              orderService.update(order);
              this.orderonlnoclient = order;
              return new ResponseEntity<>(HttpStatus.NO_CONTENT);

          }

            return ResponseEntity.ok("Đã xử lý đơn hàng từ cart thành công");
        } else {
            // Nếu cart là null, có thể xảy ra lỗi hoặc không có dữ liệu để xử lý
            // Trả về phản hồi không thành công hoặc mã lỗi phù hợp
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Không tìm thấy dữ liệu cart trong session");
        }
    }

    @GetMapping("GetorderNoClient")
    public ResponseEntity<?> getordernoclient(){
        return ResponseEntity.ok(this.orderonlnoclient);
    }

    @GetMapping("Getorder/{id}")
    public ResponseEntity<?> getorder(@PathVariable Integer id){
        Order order = orderService.getOrderById(id);
        return ResponseEntity.ok(order);
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
        List<OrderDetail> orderDetailList = orderDetailService.getallbyOrder(order);
        for (int i = 0; i < orderDetailList.size(); i++) {
            ProductDetail productDetail = orderDetailList.get(i).getProductDetail();
            productDetail.setQuantity(productDetail.getQuantity()+orderDetailList.get(i).getQuantity());
            orderDetailService.delete(orderDetailList.get(i));
        }
        orderService.delete(order.getId());
        this.orderonlnoclient=null;
        return ResponseEntity.ok().build();
    }

        @PostMapping("ThanhToan")
        public ResponseEntity<?> thanhtoan(@RequestBody Order order, RedirectAttributes redirectAttributes, HttpServletRequest request){
            Map<String, String> errorResponse = new HashMap<>();
            if (order.getHinhthucthanhtoan() == 0){
                // Trả về thông báo lỗi khi người dùng chưa đăng nhập
                errorResponse.put("error", "Vui lòng chọn hình thức thanh toán");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
            }
            order.setStatus(10);
            orderService.update(order);
            HttpSession session = request.getSession();
            Object client11 = session.getAttribute("Client");
            String email = (String) session.getAttribute("email");
            Client client = clientReponsitory.getClientByEmail(email);
            if (client!=null){
                Cart cart = cartRepository.getCartByClientAndStatus(client,0);
                List<CartDetail> cartDetail = cartDetailRepository.getCartDetailsByCart(cart);
                for (int i = 0; i < cartDetail.size(); i++) {
                    cartDetailRepository.delete(cartDetail.get(i));
                }
                cartRepository.delete(cart);
                session.removeAttribute("cart");
            }else {
                Cart cart1 = (Cart) session.getAttribute("cart");
                if (cart1!=null){
                    List<CartDetail> cartDetail = cartDetailRepository.getCartDetailsByCart(cart1);
                    for (int i = 0; i < cartDetail.size(); i++) {
                        cartDetailRepository.delete(cartDetail.get(i));
                    }
                    this.orderonlnoclient = null;
                    cartRepository.delete(cart1);
                    session.removeAttribute("cart");
                }
            }
            return ResponseEntity.ok().build();
        }

        @GetMapping("Getclient")
        public ResponseEntity<?> getclient(HttpServletRequest request){
            HttpSession session = request.getSession();
            Object client11 = session.getAttribute("Client");
            String email = (String) session.getAttribute("email");
            Client client = clientReponsitory.getClientByEmail(email);
            return ResponseEntity.ok(client);
        }

    @PostMapping("addOrderClienDiaChimacdinh/{id}")
    public ResponseEntity<?> addcarttoOrderbyclient(@PathVariable("id") Client client, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Cart cart = cartRepository.getCartByClientAndStatus(client,0);
        List<Order> listorder = orderService.getall();
        if (cart != null) {
            List<CartDetail> cartDetailList = cartDetailRepository.getCartDetailsByCart(cart);
            if (cartDetailList.size()>0){
                Order order = new Order();
                order.setClient(client);
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
                order.setMoneyShip(50000);
                order.setClient(client);
                order.setStatus(4);
                order.setSdtnhanhang(client.getPhoneNumber());
                order.setPhoneNumber(client.getPhoneNumber());
                order.setAddress(client.getLine()+"/"+client.getProvince()+"/"+client.getCity());
                order.setNguoinhan(client.getFullName());
                orderService.add(order);
                Double totalmoney=0.0;

                for (int i = 0; i < cartDetailList.size() ; i++) {
                    OrderDetail orderDetail = new OrderDetail();
                    ProductDetail productDetail = productDetailService.getonebyid(cartDetailList.get(i).getProductDetail().getId());
                    orderDetail.setOrder(order);
                    orderDetail.setProductDetail(cartDetailList.get(i).getProductDetail());
                    orderDetail.setPrice(cartDetailList.get(i).getPrice());
                    orderDetail.setQuantity(cartDetailList.get(i).getQuantity());
                    productDetail.setQuantity(productDetail.getQuantity()-cartDetailList.get(i).getQuantity());
                    orderDetail.setPrice1(cartDetailList.get(i).getQuantity()*cartDetailList.get(i).getPrice());
                    orderDetailService.add(orderDetail);
                    productDetailService.update(productDetail);
                    totalmoney += cartDetailList.get(i).getPrice()*cartDetailList.get(i).getQuantity();
                }
                order.setTotalMoney(totalmoney);
                orderService.update(order);
                LocalDate today = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String todayAsString = today.format(formatter);
                List<DiscountPeriod> getdiscountbetweenstardatandendate = discountPeriodService.getDiscountPeriodsByStartDateBeforeAndEndDateAfter(todayAsString,order.getTotalMoney());
                if (getdiscountbetweenstardatandendate.size()>0){
                    // Sắp xếp danh sách theo giá trị giảm dần
                    getdiscountbetweenstardatandendate.sort(Comparator.comparingDouble(DiscountPeriod::getValue).reversed());

                    int index = 0;
                    DiscountDetailOrder discountDetailOrder = new DiscountDetailOrder();
                    Double totalmoney1 = order.getTotalMoney();
                    int totalMoney1 = totalmoney1.intValue();
                    DiscountPeriod largestDiscountPeriod = null;
                    for (int i = 0; i < getdiscountbetweenstardatandendate.size(); i++) {
                        System.out.println(getdiscountbetweenstardatandendate.get(i).getValue());
                        System.out.println(getdiscountbetweenstardatandendate.get(i).getTonggiatritckmdagiam()+(totalMoney1 * (getdiscountbetweenstardatandendate.get(i).getValue() / 100)));
                        System.out.println(getdiscountbetweenstardatandendate.get(i).getTonggiatritckm());
                    }

                    while (index < getdiscountbetweenstardatandendate.size()) {
                        largestDiscountPeriod = getdiscountbetweenstardatandendate.get(index);
                        System.out.println(index);

                        if ((largestDiscountPeriod.getTonggiatritckmdagiam() + (totalMoney1 * (largestDiscountPeriod.getValue() / 100))) > largestDiscountPeriod.getTonggiatritckm()) {
                            index++;
                            continue;
                        }

                        discountDetailOrder.setDiscountPeriod(largestDiscountPeriod);
                        discountDetailOrder.setOrder(order);
                        discountOrderDetailSevice.add(discountDetailOrder);
                        largestDiscountPeriod.setQuantity(largestDiscountPeriod.getQuantity() - 1);
                        discountPeriodService.update(largestDiscountPeriod);

                        // Áp dụng chiết khấu cho đơn hàng
                        if (largestDiscountPeriod.getGiamToiDa() < (order.getTotalMoney() - (totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100))))) {
                            order.setChietkhau(largestDiscountPeriod.getGiamToiDa());
                        } else {
                            order.setChietkhau(order.getTotalMoney() - (totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100))));
                        }

                        // Cập nhật thông tin đơn hàng
                        largestDiscountPeriod.setTonggiatritckmdagiam(largestDiscountPeriod.getTonggiatritckmdagiam() + order.getChietkhau());
                        discountPeriodService.update(largestDiscountPeriod);
                        order.setTotalMoney(totalMoney1);
                        order.setTongtienhang(totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100)) + order.getMoneyShip());
                        orderService.update(order);

                        // Đã áp dụng chiết khấu, thoát vòng lặp
                        break;
                    }
                    this.orderonlnoclient=order;
                    return new ResponseEntity<>(HttpStatus.NO_CONTENT);

                }
                int totalMoney = totalmoney.intValue();
                order.setTotalMoney(totalMoney);
                order.setTongtienhang(order.getTotalMoney()+order.getMoneyShip());
                orderService.update(order);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            }

            return ResponseEntity.ok("Đã xử lý đơn hàng từ cart thành công");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Không tìm thấy dữ liệu cart trong session");
        }
    }

    @GetMapping("getorderbyclient/{id}")
    public ResponseEntity<?> getorderbyclient(@PathVariable("id") Client client){
        Order order = orderService.getorderbyclient(client,4);
        return ResponseEntity.ok(order);
    }

    @GetMapping("detail/{id}")
    public ResponseEntity<?> detailproductdetail(@PathVariable("id") Integer id){
        ProductDetail productDetail = productDetailService.getonebyid(id);

        System.out.println(productDetail.getProduct());

        List<ProductDetail> list = productDetailReponsitoty.findProductDetailsByAttributes(productDetail.getProduct().getId(),
        productDetail.getCategory().getId(),
                productDetail.getLace().getId(),
                productDetail.getMaterial().getId(),
                productDetail.getSockliner().getId(),
                productDetail.getSole().getId(),
                productDetail.getBrand().getId(),
                productDetail.isGender()
        );

        System.out.println(list.size());

        List<Map<String, Object>> responseData = new ArrayList<>();

        for (ProductDetail pd : list) {
            Map<String, Object> productMap = new HashMap<>();
            productMap.put("productDetail", pd);
            List<Image> imgs = imageRepository.findImageByProductDetail(pd);
            productMap.put("images", imgs);
            responseData.add(productMap);
        }

        System.out.println("plo");
        System.out.println(responseData.size());

        return new ResponseEntity<>(responseData, HttpStatus.OK);
    }


    @PostMapping("/addgiohangdetailsp")
    public ResponseEntity<String> addToCart(@RequestBody ProductDetailViewModel productDetail,HttpServletRequest request) {
        ProductDetail productDetail1 = productDetailService.getonebyid(Integer.parseInt(productDetail.getId()));
        Size size = sizeRepository.getSizeByName(productDetail.getSize());
        System.out.println(size.getName());
        Color color = colorRepository.getColorByName(productDetail.getColor());
        System.out.println(color.getName());
        ProductDetail productDetail2 = productDetailReponsitoty.findProductDetailByAttributes(productDetail1.getProduct().getId(),
                productDetail1.getCategory().getId(),
                productDetail1.getLace().getId(),
                productDetail1.getMaterial().getId(),
                productDetail1.getSockliner().getId(),
                productDetail1.getSole().getId(),
                productDetail1.getBrand().getId(),
                productDetail1.isGender(),
                size.getId(),
                color.getId()
        );

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Cart cart = (Cart) session.getAttribute("cart");
        Client client = clientReponsitory.getClientByEmail(email);
        if (client!= null) {
            Cart cart1 = cartRepository.getCartByClientAndStatus(client,0);
            if (cart1!=null){
                CartDetail cartDetail1 = cartDetailRepository.getCartDetailByCartAndProductDetail(cart1,productDetail2);
                if (cartDetail1!=null){
                    cartDetail1.setQuantity(cartDetail1.getQuantity()+1);
                    cartDetailRepository.save(cartDetail1);
                }else {
                    CartDetail cartDetail2= new CartDetail();
                    cartDetail2.setCart(cart1);
                    cartDetail2.setProductDetail(productDetail2);
                    cartDetail2.setQuantity(1);
                    cartDetail2.setPrice(productDetail2.getPrice());
                    cartDetailRepository.save(cartDetail2);
                }
            }else {
                Cart cart2 = new Cart();
                cart2.setClient(client);
                cart2.setStatus(0);
                cartRepository.save(cart2);
                CartDetail cartDetail3= new CartDetail();
                cartDetail3.setCart(cart2);
                cartDetail3.setProductDetail(productDetail2);
                cartDetail3.setQuantity(1);
                cartDetail3.setPrice(productDetail2.getPrice());
                cartDetailRepository.save(cartDetail3);
            }
            return ResponseEntity.ok("Product added to cart successfully.");
        }
        if(cart!=null){
            CartDetail cartDetail = cartDetailRepository.getCartDetailByCartAndProductDetail(cart,productDetail2);
            if (cartDetail!= null){
                cartDetail.setQuantity(cartDetail.getQuantity()+1);
                cartDetailRepository.save(cartDetail);
            }else {
                CartDetail cartDetail1 = new CartDetail();
                cartDetail1.setCart(cart);
                cartDetail1.setProductDetail(productDetail2);
                cartDetail1.setQuantity(1);
                cartDetail1.setPrice(productDetail2.getPrice());
                cartDetailRepository.save(cartDetail1);
            }
        }else {
            Cart cart1 = new Cart();
            cart1.setStatus(0);
            cart1.setClient(null);
            cartRepository.save(cart1);
            session.setAttribute("cart",cart1);
            session.setAttribute("IdCart",cart1.getId());
            CartDetail cartDetail = new CartDetail();
            cartDetail.setCart(cart1);
            cartDetail.setProductDetail(productDetail2);
            cartDetail.setPrice(productDetail2.getPrice());
            cartDetail.setQuantity(1);
            cartDetailRepository.save(cartDetail);
        }
        return ResponseEntity.ok("Sản phẩm đã được thêm vào giỏ hàng");
    }

    @GetMapping("getproductdetailaddtocartbyhome/{id}")
    public ResponseEntity<?> getproductdetailaddtocartbyhome(@PathVariable("id") ProductDetail productDetail){
        List<ProductDetail> list = productDetailReponsitoty.findProductDetailsByAttributes(productDetail.getProduct().getId(),
                productDetail.getCategory().getId(),
                productDetail.getLace().getId(),
                productDetail.getMaterial().getId(),
                productDetail.getSockliner().getId(),
                productDetail.getSole().getId(),
                productDetail.getBrand().getId(),
                productDetail.isGender()
        );
        return ResponseEntity.ok(list);
    }


    @GetMapping("search")
    public ResponseEntity<?> search(@RequestParam String keyword, @RequestParam(name = "page", defaultValue = "0") int page,
    @RequestParam(name = "size", defaultValue = "9") int size
    ) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ProductDetail> searchResult = productDetailReponsitoty.search(keyword,pageable);
        List<ProductDetailWithImagesDTO> productDetailsWithImages = new ArrayList<>();
        for (ProductDetail productDetail : searchResult.getContent()) {
            // Tạo một đối tượng DTO mới chứa thông tin sản phẩm chi tiết và hình ảnh
            ProductDetailWithImagesDTO detailWithImagesDTO = new ProductDetailWithImagesDTO();
            detailWithImagesDTO.setProductDetail(productDetail);
            // Các thông tin khác của sản phẩm chi tiết

            // Lấy danh sách hình ảnh của sản phẩm chi tiết
            List<String> imageUrls = new ArrayList<>();

            List<Image> listimgbyproductdetail = imageRepository.getByIdSp(productDetail.getId());

            for (Image image : listimgbyproductdetail) {
                // Thêm URL của hình ảnh vào danh sách
                imageUrls.add(image.getName());
            }
            // Đặt danh sách URL hình ảnh vào đối tượng DTO
            detailWithImagesDTO.setImageUrls(imageUrls);

            // Thêm đối tượng DTO vào danh sách kết quả
            productDetailsWithImages.add(detailWithImagesDTO);
        }

        // Tạo một đối tượng Page mới từ danh sách sản phẩm chi tiết kèm hình ảnh
        Page<ProductDetailWithImagesDTO> resultPage = new PageImpl<>(productDetailsWithImages, pageable, searchResult.getTotalElements());

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping("getmoney")
    public ResponseEntity<?> getmoney(@RequestParam("min") Integer min,@RequestParam("max") Integer max,
            @RequestParam(name = "page", defaultValue = "0") int page,
                                    @RequestParam(name = "size", defaultValue = "9") int size
    ) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ProductDetail> getproductbymoney = productDetailReponsitoty.getByMoney(0,min,max,pageable);
        List<ProductDetailWithImagesDTO> productDetailsWithImages = new ArrayList<>();
        for (ProductDetail productDetail : getproductbymoney.getContent()) {
            // Tạo một đối tượng DTO mới chứa thông tin sản phẩm chi tiết và hình ảnh
            ProductDetailWithImagesDTO detailWithImagesDTO = new ProductDetailWithImagesDTO();
            detailWithImagesDTO.setProductDetail(productDetail);
            // Các thông tin khác của sản phẩm chi tiết

            // Lấy danh sách hình ảnh của sản phẩm chi tiết
            List<String> imageUrls = new ArrayList<>();

            List<Image> listimgbyproductdetail = imageRepository.getByIdSp(productDetail.getId());

            for (Image image : listimgbyproductdetail) {
                // Thêm URL của hình ảnh vào danh sách
                imageUrls.add(image.getName());
            }
            // Đặt danh sách URL hình ảnh vào đối tượng DTO
            detailWithImagesDTO.setImageUrls(imageUrls);

            // Thêm đối tượng DTO vào danh sách kết quả
            productDetailsWithImages.add(detailWithImagesDTO);
        }

        // Tạo một đối tượng Page mới từ danh sách sản phẩm chi tiết kèm hình ảnh
        Page<ProductDetailWithImagesDTO> resultPage = new PageImpl<>(productDetailsWithImages, pageable, getproductbymoney.getTotalElements());

        return new ResponseEntity<>(resultPage, HttpStatus.OK);
    }

    @GetMapping("Cartdetailnopage")
    public ResponseEntity<?> getcartdetailnopage(HttpServletRequest request){
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        List<CartDetail> list  = cartDetailRepository.getCartDetailsByCart(cart);
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @PostMapping("addOrderCliendiachituychon/{id}")
    public ResponseEntity<?> addcarttoOrderbyclienttuychon(@PathVariable("id") Client client,@RequestBody orderdataOnl orderData , HttpServletRequest request) {
        HttpSession session = request.getSession();
        Cart cart = cartRepository.getCartByClientAndStatus(client,0);
        List<Order> listorder = orderService.getall();
        if (cart != null) {
            List<CartDetail> cartDetailList = cartDetailRepository.getCartDetailsByCart(cart);
            if (cartDetailList.size()>0){
                Order order = new Order();
                order.setClient(client);
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
                order.setMoneyShip(50000);
                order.setClient(client);
                order.setStatus(4);
                order.setSdtnhanhang(orderData.getPhoneNumber());
                order.setPhoneNumber(client.getPhoneNumber());
                order.setAddress(orderData.getAddress()+"/"+orderData.getDistrict()+"/"+orderData.getCity());
                order.setNguoinhan(orderData.getReceiverName());
                orderService.add(order);
                Double totalmoney=0.0;

                for (int i = 0; i < cartDetailList.size() ; i++) {
                    OrderDetail orderDetail = new OrderDetail();
                    ProductDetail productDetail = productDetailService.getonebyid(cartDetailList.get(i).getProductDetail().getId());
                    orderDetail.setOrder(order);
                    orderDetail.setProductDetail(cartDetailList.get(i).getProductDetail());
                    orderDetail.setPrice(cartDetailList.get(i).getPrice());
                    orderDetail.setQuantity(cartDetailList.get(i).getQuantity());
                    productDetail.setQuantity(productDetail.getQuantity()-cartDetailList.get(i).getQuantity());
                    orderDetail.setPrice1(cartDetailList.get(i).getQuantity()*cartDetailList.get(i).getPrice());
                    orderDetailService.add(orderDetail);
                    productDetailService.update(productDetail);
                    totalmoney += cartDetailList.get(i).getPrice()*cartDetailList.get(i).getQuantity();
                }
                order.setTotalMoney(totalmoney);
                orderService.update(order);
                LocalDate today = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String todayAsString = today.format(formatter);
                List<DiscountPeriod> getdiscountbetweenstardatandendate = discountPeriodService.getDiscountPeriodsByStartDateBeforeAndEndDateAfter(todayAsString,order.getTotalMoney());
                if (getdiscountbetweenstardatandendate.size()>0){
                    // Sắp xếp danh sách theo giá trị giảm dần
                    getdiscountbetweenstardatandendate.sort(Comparator.comparingDouble(DiscountPeriod::getValue).reversed());

                    int index = 0;
                    DiscountDetailOrder discountDetailOrder = new DiscountDetailOrder();
                    Double totalmoney1 = order.getTotalMoney();
                    int totalMoney1 = totalmoney1.intValue();
                    DiscountPeriod largestDiscountPeriod = null;
                    for (int i = 0; i < getdiscountbetweenstardatandendate.size(); i++) {
                        System.out.println(getdiscountbetweenstardatandendate.get(i).getValue());
                        System.out.println(getdiscountbetweenstardatandendate.get(i).getTonggiatritckmdagiam()+(totalMoney1 * (getdiscountbetweenstardatandendate.get(i).getValue() / 100)));
                        System.out.println(getdiscountbetweenstardatandendate.get(i).getTonggiatritckm());
                    }

                    while (index < getdiscountbetweenstardatandendate.size()) {
                        largestDiscountPeriod = getdiscountbetweenstardatandendate.get(index);
                        System.out.println(index);

                        if ((largestDiscountPeriod.getTonggiatritckmdagiam() + (totalMoney1 * (largestDiscountPeriod.getValue() / 100))) > largestDiscountPeriod.getTonggiatritckm()) {
                            index++;
                            continue;
                        }

                        discountDetailOrder.setDiscountPeriod(largestDiscountPeriod);
                        discountDetailOrder.setOrder(order);
                        discountOrderDetailSevice.add(discountDetailOrder);
                        largestDiscountPeriod.setQuantity(largestDiscountPeriod.getQuantity() - 1);
                        discountPeriodService.update(largestDiscountPeriod);

                        // Áp dụng chiết khấu cho đơn hàng
                        if (largestDiscountPeriod.getGiamToiDa() < (order.getTotalMoney() - (totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100))))) {
                            order.setChietkhau(largestDiscountPeriod.getGiamToiDa());
                        } else {
                            order.setChietkhau(order.getTotalMoney() - (totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100))));
                        }

                        // Cập nhật thông tin đơn hàng
                        largestDiscountPeriod.setTonggiatritckmdagiam(largestDiscountPeriod.getTonggiatritckmdagiam() + order.getChietkhau());
                        discountPeriodService.update(largestDiscountPeriod);
                        order.setTotalMoney(totalMoney1);
                        order.setTongtienhang(totalMoney1 - (totalMoney1 * (largestDiscountPeriod.getValue() / 100)) + order.getMoneyShip());
                        orderService.update(order);

                        // Đã áp dụng chiết khấu, thoát vòng lặp
                        break;
                    }
                    this.orderonlnoclient=order;
                    return new ResponseEntity<>(HttpStatus.NO_CONTENT);

                }
                int totalMoney = totalmoney.intValue();
                order.setTotalMoney(totalMoney);
                order.setTongtienhang(order.getTotalMoney()+order.getMoneyShip());
                orderService.update(order);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);

            }

            return ResponseEntity.ok("Đã xử lý đơn hàng từ cart thành công");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Không tìm thấy dữ liệu cart trong session");
        }
    }

    @GetMapping("listProdyctByOrder/{id}")
    public ResponseEntity<?> getProductByOrder(@PathVariable("id") Order order,@RequestParam(name = "page", defaultValue = "0") int page,
                                               @RequestParam(name = "size", defaultValue = "3") int size){
        Pageable pageable = PageRequest.of(page, size);
        Page<OrderDetail> getallbyOrder = orderDetailReponsitory.findOrderDetailByOrder(order,pageable);
        return new ResponseEntity<>(getallbyOrder , HttpStatus.OK);
    }

}
