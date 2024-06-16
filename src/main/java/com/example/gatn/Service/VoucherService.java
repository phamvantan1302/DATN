package com.example.gatn.Service;

import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.Voucher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface VoucherService {
    Page<Voucher> getpageall(Pageable pageable);


    List<Voucher> getallvoucher();

    void saveall(List<Voucher> voucherList);

    Page<Voucher> search(String textsearch,Pageable pageable);

    Voucher getonebyid(Integer id);

    Voucher getVoucherbycode(String code);

    void delete(Voucher voucher);

    void add(Voucher voucher);

    void update(Voucher voucher);

    Page<Voucher> getVoucherByStatus(int status, Pageable pageable);

    void updatestatus();

    List<Voucher> getvoucherbyhoadon(Double totalmoney);

    Page<Voucher> searchVoucher(String keyword,int page,int size);
}
