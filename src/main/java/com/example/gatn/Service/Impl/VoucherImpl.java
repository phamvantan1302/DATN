package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.Voucher;
import com.example.gatn.Repositoris.VoucherReponsitory;
import com.example.gatn.Service.VoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class VoucherImpl implements VoucherService {
    @Autowired
    private VoucherReponsitory voucherReponsitory ;
    @Override
    public Page<Voucher> getpageall(Pageable pageable) {
        return voucherReponsitory.findAll(pageable);
    }

    @Override
    public List<Voucher> getallvoucher() {
        return voucherReponsitory.findAll();
    }

    @Override
    public void saveall(List<Voucher> voucherList) {
        voucherReponsitory.saveAll(voucherList);
    }

    @Override
    public Page<Voucher> search(String textsearch, Pageable pageable) {
        return voucherReponsitory.searchVouchers(textsearch,pageable);
    }

    @Override
    public Voucher getonebyid(Integer id) {
        return voucherReponsitory.findVoucherById(id);
    }

    @Override
    public Voucher getVoucherbycode(String code) {
        return voucherReponsitory.findVoucherByCode(code);
    }

    @Override
    public void delete(Voucher voucher) {
        voucherReponsitory.delete(voucher);
    }

    @Override
    public void add(Voucher voucher) {
        voucherReponsitory.save(voucher);
    }

    @Override
    public void update(Voucher voucher) {
        voucherReponsitory.save(voucher);
    }

    @Override
    public Page<Voucher> getVoucherByStatus(int status, Pageable pageable) {
        return voucherReponsitory.findByStatus(status,pageable);
    }

    @Override
    public void updatestatus() {
        List<Voucher> list = voucherReponsitory.getVouchersByStatus(0);
        // Lặp qua từng voucher và kiểm tra ngày kết thúc
        Date currentDate = new Date();
        for (Voucher voucher : list) {
            if (voucher.getEndDate().before(currentDate)) {
                // Nếu ngày kết thúc đã qua, cập nhật trạng thái của voucher
                voucher.setStatus(2);
                voucherReponsitory.save(voucher);
            }
        }
    }

    @Override
    public List<Voucher> getvoucherbyhoadon(Double totalmoney) {
        return voucherReponsitory.getAllByDieukienbatdauLessThan(totalmoney);
    }

    @Override
    public Page<Voucher> searchVoucher(String keyword, int page, int size) {
        return null;
    }
}
