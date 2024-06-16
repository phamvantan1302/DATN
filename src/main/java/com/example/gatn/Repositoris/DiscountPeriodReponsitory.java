package com.example.gatn.Repositoris;

import com.example.gatn.Entity.DiscountPeriod;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface DiscountPeriodReponsitory extends JpaRepository<DiscountPeriod,Integer> {
    @Override
    Page<DiscountPeriod> findAll(Pageable pageable);

    Page<DiscountPeriod> findByStatus(int status, Pageable pageable);

    @Query(value = "SELECT * FROM discount_period d " +
            "WHERE d.code LIKE CONCAT('%', :keyword, '%') OR " +
            "d.name LIKE CONCAT('%', :keyword, '%') OR " +
            "d.start_date LIKE CONCAT('%', :keyword, '%') OR " +
            "d.end_date LIKE CONCAT('%', :keyword, '%') OR " +
            "d.description LIKE CONCAT('%', :keyword, '%') OR " +
            "CAST(d.value AS CHAR) LIKE CONCAT('%', :keyword, '%') OR " +
            "CAST(d.star_price AS CHAR) LIKE CONCAT('%', :keyword, '%') OR " +
            "CAST(d.end_price AS CHAR) LIKE CONCAT('%', :keyword, '%') OR " +
            "CAST(d.quantity AS CHAR) LIKE CONCAT('%', :keyword, '%') OR " +
            "CAST(d.category AS CHAR) LIKE CONCAT('%', :keyword, '%') OR " +
            "CAST(d.status AS CHAR) LIKE CONCAT('%', :keyword, '%') OR " +
            "CAST(d.tonggiam AS CHAR) LIKE CONCAT('%', :keyword, '%')", nativeQuery = true)
    Page<DiscountPeriod> search(@Param("keyword") String keyword,Pageable pageable);

    @Query("SELECT dp FROM DiscountPeriod dp WHERE :today BETWEEN dp.startDate AND dp.endDate AND dp.quantity > 0 And dp.starPrice <= :totalmoney and :totalmoney<= dp.endPrice and dp.status = 0 and dp.tonggiatritckm>dp.tonggiatritckmdagiam")
    List<DiscountPeriod> getDiscountPeriodsByStartDateBeforeAndEndDateAfter(@Param("today") String today,Double totalmoney);
}
