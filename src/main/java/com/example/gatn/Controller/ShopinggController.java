package com.example.gatn.Controller;

import com.example.gatn.Entity.*;
import com.example.gatn.Repositoris.ClientReponsitory;
import com.example.gatn.Repositoris.ImageRepository;
import com.example.gatn.Repositoris.OrderReponsitory;
import com.example.gatn.Repositoris.ProductDetailReponsitoty;
import com.example.gatn.Service.Impl.OrderDetailImpl;
import com.example.gatn.Service.Impl.OrderImpl;
import com.example.gatn.Service.Impl.ProductDetailImpl;
import com.example.gatn.Service.OrderDetailService;
import com.example.gatn.Service.OrderService;
import com.example.gatn.Service.ProductDetailService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/AdidasSporst")
public class ShopinggController {

    @Autowired
    private ProductDetailReponsitoty productDetailReponsitoty;

    @Autowired
    private ProductDetailService productDetailService = new ProductDetailImpl();
    @Autowired
    private ImageRepository imageRepository;

    @Autowired
    private OrderDetailService orderDetailService = new OrderDetailImpl();

    @Autowired
    private ClientReponsitory clientReponsitory;

    @Autowired
    private OrderReponsitory orderReponsitory;
    @GetMapping("home")
    public String demo(){
        return "Online/layout2";
    }

    @GetMapping("login")
    public String login(){
        return "Online/Login";
    }

    @GetMapping("ThanhToan2/{totalmoney}")
    public String thanhtoan(@PathVariable String totalmoney,Model model){
        Integer totalAmount = Integer.parseInt(totalmoney.split("\\.")[0]);
        model.addAttribute("totalAmount", totalAmount);
        return "Online/thanhtoan";
    }

    @GetMapping("Detail/{id}")
    public String Detail(@PathVariable Integer id,Model model){
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
        List<Image> imgs= new ArrayList<>();

        System.out.println("pji");
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i).getSize());
        }

        for (int i = 0; i < list.size(); i++){
            Map<String, Object> productMap = new HashMap<>();
            productMap.put("productDetail", list.get(i));
            imgs.addAll(imageRepository.findImageByProductDetail(list.get(i)));
            productMap.put("images", imgs);
            responseData.add(productMap);
        }
        model.addAttribute("img",imgs);
        model.addAttribute("res", responseData);
        return "Online/detail";
    }

    @GetMapping("Order/{id}")
    public String getOrder(@PathVariable("id") Integer id,
                           @RequestParam(value = "page", defaultValue = "0") int page,
                           @RequestParam(value = "size", defaultValue = "4") int size,
                           Model model) {
        Client client = clientReponsitory.getReferenceById(id);
        Pageable pageable = PageRequest.of(page, size);
        Page<Order> orderPage = orderReponsitory.getByClient1(client.getId(), pageable);

        model.addAttribute("orderPage", orderPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        return "Online/orderclient";
    }


}
