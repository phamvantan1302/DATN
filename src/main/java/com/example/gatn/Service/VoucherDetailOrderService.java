package com.example.gatn.Service;

import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.Voucher;
import com.example.gatn.Entity.VoucherDetail;

import java.util.List;

public interface VoucherDetailOrderService {
    void add(VoucherDetail voucherDetail);
    void update(VoucherDetail voucherDetail);
    List<VoucherDetail> getlist();
    void delete(VoucherDetail voucherDetail);
    List<VoucherDetail> listvoucherdetailbyorder(Order order);
    VoucherDetail getvoucherdetailbyorderandvoucher(Order order, Voucher voucher);

}
