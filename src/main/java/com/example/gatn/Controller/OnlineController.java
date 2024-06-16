package com.example.gatn.Controller;

import com.example.gatn.Entity.*;
import com.example.gatn.Entity.Color;
import com.example.gatn.Entity.Image;
import com.example.gatn.Repositoris.*;
import com.example.gatn.Service.ImageService;
import com.example.gatn.Service.ProductDetailService;
import com.example.gatn.config.Config;
import jdk.swing.interop.SwingInterOpUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.awt.*;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/adidas")
public class OnlineController {

    private List<CheckCart> lscc = new ArrayList<>();

    private CheckKhachHang ckh;

    private List<CheckCartDetail> lscheckcartdetail = new ArrayList<>();

    @Autowired
    private ImageRepository imageRepository;

//    @Autowired
//    private ImageService imageService;

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private ProductDetailReponsitoty productDetailReponsitoty;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private BrandRepository brandRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ColorRepository colorRepository;

    @Autowired
    private LaceRepository laceRepository;

    @Autowired
    private MaterialRepository materialRepository;

    @Autowired
    private SizeRepository sizeRepository;

    @Autowired
    private SocklinerRepository socklinerRepository;

    @Autowired
    private SoleRepository soleRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @Autowired
    private ClientReponsitory clientRepository;

    @Autowired
    private DiscountPeriodReponsitory discountPeriodReponsitory;

    @Autowired
    private OrderReponsitory orderRepository;

    @GetMapping("/hien-thi")
    public String hienthi(@RequestParam(defaultValue = "0", name = "page") Integer number, Model model) {
        Pageable pageable = PageRequest.of(number, 8);
        List<Image> image = imageRepository.findAll();
        List<Category> category = categoryRepository.findAll();
        List<Size> size = sizeRepository.findAll();
        List<Product> product = productRepository.findAll();
        List<Material> material = materialRepository.findAll();
        List<Brand> brand = brandRepository.findAll();
        List<Color> color = colorRepository.findAll();
        List<Sole> sole = soleRepository.findAll();
        List<Lace> lace = laceRepository.findAll();
        List<Sockliner> sockliner = socklinerRepository.findAll();
        Page<ProductDetail> listproduct = productDetailService.getall(0, pageable);
        model.addAttribute("listprd", listproduct);
        model.addAttribute("image", image);
        model.addAttribute("category", category);
        model.addAttribute("size", size);
        model.addAttribute("product", product);
        model.addAttribute("material", material);
        model.addAttribute("brand", brand);
        model.addAttribute("color", color);
        model.addAttribute("sole", sole);
        model.addAttribute("lace", lace);
        model.addAttribute("sockliner", sockliner);
        return "home/index";
    }

    @GetMapping("/searchname")
    public String search(@RequestParam( defaultValue = "0", name = "page") Integer number,
                         Model model, @RequestParam("keySearch") String key){
        Pageable pageable = PageRequest.of(number, 8);
        List<Image> image = imageRepository.findAll();
        List<Category> category = categoryRepository.findAll();
        List<Size> size = sizeRepository.findAll();
        List<Product> product = productRepository.findAll();
        List<Material> material = materialRepository.findAll();
        List<Brand> brand = brandRepository.findAll();
        List<Color> color = colorRepository.findAll();
        List<Sole> sole = soleRepository.findAll();
        List<Lace> lace = laceRepository.findAll();
        List<Sockliner> sockliner = socklinerRepository.findAll();
        Page<ProductDetail> listproduct = productDetailService.getall(0, pageable);
        if(key != null){
            listproduct = productDetailService.searchhome(key,0, pageable);
        }
        model.addAttribute("listprd", listproduct);
        model.addAttribute("image", image);
        model.addAttribute("category", category);
        model.addAttribute("size", size);
        model.addAttribute("product", product);
        model.addAttribute("material", material);
        model.addAttribute("brand", brand);
        model.addAttribute("color", color);
        model.addAttribute("sole", sole);
        model.addAttribute("lace", lace);
        model.addAttribute("sockliner", sockliner);
        return "home/index";
    }

    @GetMapping("/locmoney")
    public String filterList(@RequestParam( defaultValue = "0", name = "page") Integer number,
                             @RequestParam("locmoney") String keyLoc, Model model) {
        int a =0,b=0;
        if(keyLoc.equals("0")){
            a=0;
            b=300000;
        }if(keyLoc.equals("1")){
            a=300000;
            b=600000;
        }if(keyLoc.equals("2")){
            a=600000;
            b=1000000;
        }if(keyLoc.equals("3")){
            a=1000000;
            b=1000000000;
        }if(keyLoc.equals("")){
            a=0;
            b=1000000000;
        }
        System.out.println("111111111111111111111111111111");
        System.out.println(keyLoc);
//        System.out.println(a);
//        System.out.println(b);
        Pageable pageable = PageRequest.of(number, 8);
        List<Image> image = imageRepository.findAll();
        List<Category> category = categoryRepository.findAll();
        List<Size> size = sizeRepository.findAll();
        List<Product> product = productRepository.findAll();
        List<Material> material = materialRepository.findAll();
        List<Brand> brand = brandRepository.findAll();
        List<Color> color = colorRepository.findAll();
        List<Sole> sole = soleRepository.findAll();
        List<Lace> lace = laceRepository.findAll();
        List<Sockliner> sockliner = socklinerRepository.findAll();
        Page<ProductDetail> listproduct = productDetailService.getByMoney(0, a, b, pageable);
        model.addAttribute("listprd", listproduct);
        model.addAttribute("image", image);
        model.addAttribute("category", category);
        model.addAttribute("size", size);
        model.addAttribute("product", product);
        model.addAttribute("material", material);
        model.addAttribute("brand", brand);
        model.addAttribute("color", color);
        model.addAttribute("sole", sole);
        model.addAttribute("lace", lace);
        model.addAttribute("sockliner", sockliner);
        return "home/index";
    }

    @GetMapping("/detailsp/{id}")
    public String detailsp(@PathVariable("id") String id, Model model) {
        ProductDetail Productdetail = productDetailReponsitoty.findById(Integer.valueOf(id)).orElse(null);
        List<Image> images = imageRepository.findAll();
        List<Category> category = categoryRepository.findAll();
        List<Size> size = sizeRepository.findAll();
        List<Product> product = productRepository.findAll();
        List<Material> material = materialRepository.findAll();
        List<Brand> brand = brandRepository.findAll();
        List<Color> color = colorRepository.findAll();
        List<Sole> sole = soleRepository.findAll();
        List<Lace> lace = laceRepository.findAll();
        List<Sockliner> sockliner = socklinerRepository.findAll();
        model.addAttribute("sp", Productdetail);
        model.addAttribute("image", images);
        model.addAttribute("category", category);
        model.addAttribute("size", size);
        model.addAttribute("product", product);
        model.addAttribute("material", material);
        model.addAttribute("brand", brand);
        model.addAttribute("color", color);
        model.addAttribute("sole", sole);
        model.addAttribute("lace", lace);
        model.addAttribute("sockliner", sockliner);
        return "home/detailsp";
    }

    @GetMapping("/hienthi")
    public String hienthicart(Model model) {
        if (ckh == null) {
            List<CheckCartDetail> list = lscheckcartdetail;
            model.addAttribute("listc", list);
        } else {
            List<Cart> cart = cartRepository.findAll();
            List<CartDetail> list = cartDetailRepository.findAll();
            model.addAttribute("lscart", cart);
            model.addAttribute("listc", list);
        }
        return "home/giohang";
    }

    @GetMapping("/donhang")
    public String donhang(Model model){
        if(ckh == null){
        }else{
            List<Order> list = orderRepository.getByClient(ckh.getId());
            model.addAttribute("order", list);
        }
        return "home/lichsudh";
    }

    @GetMapping("/gioithieu")
    public String hienthiGT(Model model){
        return "home/aboutus";
    }

    @GetMapping("/lienhe")
    public String hienthiLH(Model model){
        return "home/lienhe";
    }

    @GetMapping("delete/{id}/{iddetail}")
    public String deleteCart(@PathVariable("id") String id, @PathVariable("iddetail") String iddetail) {
        if (ckh == null) {
            List<CheckCartDetail> list = lscheckcartdetail;
            list.removeIf(detail -> detail.getId() == Integer.valueOf(iddetail));
            List<CheckCart> ls = lscc;
            ls.removeIf(detail ->detail.getId() == Integer.valueOf(id));
        } else {
            cartDetailRepository.deleteById(Integer.valueOf(iddetail));
            cartRepository.deleteById(Integer.valueOf(id));
        }
        return "redirect:/adidas/hienthi";
    }

    @GetMapping("truslgio/{id}")
    public String truslgio(@PathVariable("id") String id){
        if (ckh == null) {
            for (CheckCartDetail detail : lscheckcartdetail){
                if (detail.getQuantity() > 0) {
                    detail.setQuantity(detail.getQuantity() - 1);
                    detail.setSubtotal((float) (detail.getQuantity() * detail.getPrice()));
                    break;
                }
            }

        } else {
//            for(CartDetail cd: listdt){
//                ProductDetail findProduct = productDetailReponsitoty.findById(Integer.valueOf(cd.getId())).orElse(null);
//                findProduct.setQuantity(findProduct.getQuantity()-cd.getQuantity());
//            }
        }
        return "redirect:/adidas/hienthi";
    }

    @GetMapping("congslgio/{id}")
    public String congslgio(@PathVariable("id") String id){
        if (ckh == null) {
            for (CheckCartDetail detail : lscheckcartdetail){
                if (detail.getProductDetail().getId() == Integer.valueOf(id)) {
                    detail.setQuantity(detail.getQuantity() + 1);
                    detail.setSubtotal((float) (detail.getQuantity() * detail.getPrice()));
                    break;
                }
            }

        } else {
//            for(CartDetail cd: listdt){
//                ProductDetail findProduct = productDetailReponsitoty.findById(Integer.valueOf(cd.getId())).orElse(null);
//                findProduct.setQuantity(findProduct.getQuantity()-cd.getQuantity());
//            }
        }
        return "redirect:/adidas/hienthi";
    }

    @GetMapping("/addgioctsp/{id}")
    public String addGioCtSp(@PathVariable("id") String id){
        int quantity = 1;
        java.util.Date date = new java.util.Date();
        ProductDetail productdetail = productDetailReponsitoty.findById(Integer.valueOf(id)).orElse(null);
        if (ckh == null) {
            if (lscheckcartdetail.size() == 0) {
                CheckCart ls = new CheckCart(productdetail.getId(), null, date, null);
                lscheckcartdetail.add(new CheckCartDetail(productdetail.getId(), ls, productdetail, quantity, productdetail.getPrice(), quantity * productdetail.getPrice()));
            } else {
                for (CheckCartDetail detail : lscheckcartdetail) {
                    if (detail.getProductDetail().getId() == Integer.valueOf(id)) {
                        detail.setQuantity(detail.getQuantity() + 1);
                        detail.setSubtotal((float) (detail.getQuantity() * detail.getPrice()));
                        break;
                    }else{
                        CheckCart ls = new CheckCart(productdetail.getId(), null, date, null);
                        lscheckcartdetail.add(new CheckCartDetail(productdetail.getId(), ls, productdetail, quantity, productdetail.getPrice(), quantity * productdetail.getPrice()));
                        break;
                    }
                }
            }
        } else {
            //them vao gio db
            System.out.println("vao khach hang no null");

            if (lscheckcartdetail.size() == 0) {
                Client client = clientRepository.findById(ckh.id).orElse(null);
                Cart cart = Cart.builder()
                        .client(client)
                        .createDate(date)
                        .dateOfPayment(null)
                        .build();
                cartRepository.save(cart);
                CartDetail cartDetail = CartDetail.builder()
                        .cart(cart)
                        .productDetail(productdetail)
                        .quantity(quantity)
                        .price(productdetail.getPrice())
                        .subtotal(quantity * productdetail.getPrice())
                        .build();
                cartDetailRepository.save(cartDetail);
            } else {
                List<CartDetail> lscartdetail = cartDetailRepository.findAll();
                for (CartDetail detail : lscartdetail) {
                    if (detail.getProductDetail().getId() == Integer.valueOf(id)) {
                        detail.setQuantity(detail.getQuantity() + 1);
                        detail.setSubtotal((float) (detail.getQuantity() * detail.getPrice()));
                        CartDetail findcart = cartDetailRepository.findById(Integer.valueOf(id)).orElse(null);
                        detail.setId(findcart.getId());
                        BeanUtils.copyProperties(detail, findcart);
                        cartDetailRepository.save(findcart);
                        break;
                    }else{
                        Client client = clientRepository.findById(ckh.id).orElse(null);
                        Cart cart = Cart.builder()
                                .client(client)
                                .createDate(date)
                                .dateOfPayment(null)
                                .build();
                        cartRepository.save(cart);
                        Cart carts = cartRepository.findById(cart.getId()).orElse(null);
                        CartDetail cartDetail = CartDetail.builder()
                                .cart(carts)
                                .productDetail(productdetail)
                                .quantity(quantity)
                                .price(productdetail.getPrice())
                                .subtotal(quantity * productdetail.getPrice())
                                .build();
                        cartDetailRepository.save(cartDetail);
                        break;
                    }
                }

            }
        }
        return "redirect:/adidas/hien-thi";
    }
    @GetMapping("/addcart/{id}")
    public String addCart(@PathVariable("id") String id) {

        int quantity = 1;
        java.util.Date date = new java.util.Date();
        ProductDetail productdetail = productDetailReponsitoty.findById(Integer.valueOf(id)).orElse(null);
        if (ckh == null) {
            if (lscheckcartdetail.size() == 0) {
                CheckCart ls = new CheckCart(productdetail.getId(), null, date, null);
                lscheckcartdetail.add(new CheckCartDetail(productdetail.getId(), ls, productdetail, quantity, productdetail.getPrice(), quantity * productdetail.getPrice()));
            } else {
                for (CheckCartDetail detail : lscheckcartdetail) {
                    if (detail.getProductDetail().getId() == Integer.valueOf(id)) {
                        detail.setQuantity(detail.getQuantity() + 1);
                        detail.setSubtotal((float) (detail.getQuantity() * detail.getPrice()));
                        break;
                    }else{
                        CheckCart ls = new CheckCart(productdetail.getId(), null, date, null);
                        lscheckcartdetail.add(new CheckCartDetail(productdetail.getId(), ls, productdetail, quantity, productdetail.getPrice(), quantity * productdetail.getPrice()));
                        break;
                    }
                }
            }
        } else {
            //them vao gio db
            System.out.println("vao khach hang no null");

            if (lscheckcartdetail.size() == 0) {
                Client client = clientRepository.findById(ckh.id).orElse(null);
                Cart cart = Cart.builder()
                        .client(client)
                        .createDate(date)
                        .dateOfPayment(null)
                        .build();
                cartRepository.save(cart);
                CartDetail cartDetail = CartDetail.builder()
                        .cart(cart)
                        .productDetail(productdetail)
                        .quantity(quantity)
                        .price(productdetail.getPrice())
                        .subtotal(quantity * productdetail.getPrice())
                        .build();
                cartDetailRepository.save(cartDetail);
            } else {
                List<CartDetail> lscartdetail = cartDetailRepository.findAll();
                for (CartDetail detail : lscartdetail) {
                    if (detail.getProductDetail().getId() == Integer.valueOf(id)) {
                        detail.setQuantity(detail.getQuantity() + 1);
                        detail.setSubtotal((float) (detail.getQuantity() * detail.getPrice()));
                        CartDetail findcart = cartDetailRepository.findById(Integer.valueOf(id)).orElse(null);
                        detail.setId(findcart.getId());
                        BeanUtils.copyProperties(detail, findcart);
                        cartDetailRepository.save(findcart);
                        break;
                    }else{
                        Client client = clientRepository.findById(ckh.id).orElse(null);
                        Cart cart = Cart.builder()
                                .client(client)
                                .createDate(date)
                                .dateOfPayment(null)
                                .build();
                        cartRepository.save(cart);
                        Cart carts = cartRepository.findById(cart.getId()).orElse(null);
                        CartDetail cartDetail = CartDetail.builder()
                                .cart(carts)
                                .productDetail(productdetail)
                                .quantity(quantity)
                                .price(productdetail.getPrice())
                                .subtotal(quantity * productdetail.getPrice())
                                .build();
                        cartDetailRepository.save(cartDetail);
                        break;
                    }
                }

            }
        }
        return "redirect:/adidas/hien-thi";
    }

    @PostMapping("/hienthiorder")
    public String getOrder( Model model){
        List<DiscountPeriod> discountPeriods = discountPeriodReponsitory.findAll();
        model.addAttribute("discountPeriods", discountPeriods);
        List<CheckCartDetail> list = lscheckcartdetail;
        List<Cart> cart = cartRepository.findAll();
        List<CartDetail> listdt = cartDetailRepository.findAll();
        if (ckh == null) {

            model.addAttribute("listc", list);
        } else {
            model.addAttribute("lscart", cart);
            model.addAttribute("listc", listdt);
        }
        return "home/thanhtoan";
    }

    @PostMapping("/addorder")
    public String addOrder(@RequestParam("summoney") String tong, @RequestParam("phone_number") String numberPhone,
                           @RequestParam("address") String address,@RequestParam("name") String name,
                           @RequestParam("email") String mail, @RequestParam("mavoucher") String codeDis){
        LocalDate currentDate = LocalDate.now();
        Date currentJavaDate = java.sql.Date.valueOf(currentDate);
        Order order = Order.builder()
                .phoneNumber(numberPhone)
                .address(address)
                .useName(name)
                .email(mail)
                .itemDiscount(codeDis)
                .totalMoney(Double.valueOf(tong))
                .shipDate(currentJavaDate)
                .completionDate(currentJavaDate)
                .note("")
                .moneyShip(0)
                .createDate(currentJavaDate)
                .dateOfPayment(currentJavaDate)
                .lastModifiedDate(currentJavaDate)
                .createdBy("")
                .status(0)
                .build();
        orderRepository.save(order);

        List<CheckCartDetail> listcheck = lscheckcartdetail;

        //UPDATE sl
        List<CartDetail> listdt = cartDetailRepository.findAll();
        if (ckh == null) {
            for(CheckCartDetail cd: listcheck){
                ProductDetail findProduct = productDetailReponsitoty.findById(Integer.valueOf(cd.getId())).orElse(null);
                findProduct.setQuantity(findProduct.getQuantity()-cd.getQuantity());
                productDetailService.add(findProduct);
            }

        } else {
            for(CartDetail cd: listdt){
                ProductDetail findProduct = productDetailReponsitoty.findById(Integer.valueOf(cd.getId())).orElse(null);
                findProduct.setQuantity(findProduct.getQuantity()-cd.getQuantity());
                productDetailService.add(findProduct);
            }
        }



//        delete gio hang

        listcheck.clear();
        return "redirect:/adidas/hien-thi";
    }

//    @PostMapping("/vnpay")
//    public String ttvnpay( @RequestParam("summoney") String tong, @RequestParam("phone_number") String numberPhone,
//                           @RequestParam("address") String address,@RequestParam("name") String name,
//                           @RequestParam("email") String mail, @RequestParam("") String codeDis) throws UnsupportedEncodingException {
//
//        String vnp_Version = "2.1.0";
//        String vnp_Command = "pay";
//
//        Double amount = Double.valueOf(tong)*100;
//        String bankCode = "NCB";
//
//        String vnp_TxnRef = Config.getRandomNumber(8);
//
//        String vnp_TmnCode = Config.vnp_TmnCode;
//
//        Map<String, String> vnp_Params = new HashMap<>();
//        vnp_Params.put("vnp_Version", vnp_Version);
//        vnp_Params.put("vnp_Command", vnp_Command);
//        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
//        vnp_Params.put("vnp_Amount", String.valueOf(amount));
//        vnp_Params.put("vnp_CurrCode", "VND");
//        vnp_Params.put("vnp_BankCode", bankCode);
//
//        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
//        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
//        vnp_Params.put("vnp_Locale", "vn");
////        vnp_Params.put("vnp_OrderType", orderType);
//
//        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
//
//        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
//        String vnp_CreateDate = formatter.format(cld.getTime());
//        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
//
//        cld.add(Calendar.MINUTE, 15);
//        String vnp_ExpireDate = formatter.format(cld.getTime());
//        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
//
//        List fieldNames = new ArrayList(vnp_Params.keySet());
//        Collections.sort(fieldNames);
//        StringBuilder hashData = new StringBuilder();
//        StringBuilder query = new StringBuilder();
//        Iterator itr = fieldNames.iterator();
//        while (itr.hasNext()) {
//            String fieldName = (String) itr.next();
//            String fieldValue = (String) vnp_Params.get(fieldName);
//            if ((fieldValue != null) && (fieldValue.length() > 0)) {
//                //Build hash data
//                hashData.append(fieldName);
//                hashData.append('=');
//                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
//                //Build query
//                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
//                query.append('=');
//                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
//                if (itr.hasNext()) {
//                    query.append('&');
//                    hashData.append('&');
//                }
//            }
//        }
//        String queryUrl = query.toString();
//        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
//        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
//        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
////        com.google.gson.JsonObject job = new JsonObject();
////        job.addProperty("code", "00");
////        job.addProperty("message", "success");
////        job.addProperty("data", paymentUrl);
////        Gson gson = new Gson();
////        resp.getWriter().write(gson.toJson(job));
//
//            //Them thong tin thanh toan.
//        LocalDate currentDate = LocalDate.now();
//        Order order = Order.builder()
//                .phoneNumber(numberPhone)
//                .address(address)
//                .useName(name)
//                .email(mail)
//                .itemDiscount(codeDis)
//                .totalMoney(amount)
//                .confirmedDate(currentDate)
//                .shipDate(LocalDate.now())
//                .completionDate(LocalDate.now())
//                .note("")
//                .moneyShip(0)
//                .createDate(java.time.LocalDate.now())
//                .dateOfPayment(java.time.LocalDate.now())
//                .lastModifiedDate(java.time.LocalDate.now())
//                .createdBy("")
//                .update("")
//                .status(0)
//                .build();
//        orderRepository.save(order);
//
//        return paymentUrl;
//    }

    @GetMapping("/login")
    public String dangNhap(Model model){

        return "home/login";
        //return "admin/hien-thi";
    }
}
