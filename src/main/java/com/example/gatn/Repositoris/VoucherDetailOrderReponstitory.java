package com.example.gatn.Repositoris;

import com.example.gatn.Entity.Order;
import com.example.gatn.Entity.Voucher;
import com.example.gatn.Entity.VoucherDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VoucherDetailOrderReponstitory extends JpaRepository<VoucherDetail,Integer> {
    void deleteAllByOrder(Order order);
    List<VoucherDetail> findAllByOrder(Order order);
    VoucherDetail findVoucherDetailByOrderAndVoucher(Order order, Voucher voucher);
}
