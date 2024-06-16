package com.example.gatn.Repositoris;

import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Entity.Voucher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VoucherReponsitory extends JpaRepository<Voucher,Integer> {
    @Override
    Page<Voucher> findAll(Pageable pageable);

    Page<Voucher> findByStatus(int status, Pageable pageable);

    Voucher findVoucherByCode(String code);

    Voucher findVoucherById(Integer id);

    // Truy vấn tìm kiếm và phân trang theo nhiều trường
    @Query(value = "SELECT * FROM voucher v WHERE " +
            "LOWER(v.code) LIKE LOWER(CONCAT('%', :searchText, '%')) OR " +
            "LOWER(v.value) LIKE LOWER(CONCAT('%', :searchText, '%')) OR " +
            "LOWER(v.end_date) LIKE LOWER(CONCAT('%', :searchText, '%')) OR " +
            "LOWER(v.quantity) LIKE LOWER(CONCAT('%', :searchText, '%')) OR " +
            "LOWER(v.menhGia) LIKE LOWER(CONCAT('%', :searchText, '%')) OR " +
            "LOWER(v.dieukienbatdau) LIKE LOWER(CONCAT('%', :searchText, '%')) OR " +
            "LOWER(v.status) LIKE LOWER(CONCAT('%', :searchText, '%'))", nativeQuery = true
    )
    Page<Voucher> searchVouchers(@Param("searchText") String searchText, Pageable pageable);

    List<Voucher> getAllByDieukienbatdauLessThan(Double gia);

    List<Voucher> getVouchersByStatus(Integer status);
}
