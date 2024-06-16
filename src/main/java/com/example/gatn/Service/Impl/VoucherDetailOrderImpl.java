package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.Voucher;
import com.example.gatn.Entity.VoucherDetail;
import com.example.gatn.Repositoris.VoucherDetailOrderReponstitory;
import com.example.gatn.Service.VoucherDetailOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VoucherDetailOrderImpl implements VoucherDetailOrderService {
    @Autowired
    private VoucherDetailOrderReponstitory voucherDetailOrderReponstitory;

    @Override
    public void add(VoucherDetail voucherDetail) {
        voucherDetailOrderReponstitory.save(voucherDetail);
    }

    @Override
    public void update(VoucherDetail voucherDetail) {
        voucherDetailOrderReponstitory.save(voucherDetail);
    }

    @Override
    public List<VoucherDetail> getlist() {
        return voucherDetailOrderReponstitory.findAll();
    }

    @Override
    public void delete(VoucherDetail voucherDetail) {
        voucherDetailOrderReponstitory.delete(voucherDetail);
    }

    @Override
    public List<VoucherDetail> listvoucherdetailbyorder(Order order) {
        return voucherDetailOrderReponstitory.findAllByOrder(order);
    }

    @Override
    public VoucherDetail getvoucherdetailbyorderandvoucher(Order order, Voucher voucher) {
        return voucherDetailOrderReponstitory.findVoucherDetailByOrderAndVoucher(order, voucher);
    }


}
