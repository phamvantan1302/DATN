package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Repositoris.DiscountPeriodReponsitory;
import com.example.gatn.Service.DiscountPeriodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class DiscountPeriodImpl implements DiscountPeriodService {
    @Autowired
    private DiscountPeriodReponsitory discountPeriodReponsitory;

    @Override
    public Page<DiscountPeriod> getpageall(int page,int size) {
        return discountPeriodReponsitory.findAll(PageRequest.of(page,size));
    }

    @Override
    public DiscountPeriod getonebyid(Integer id) {
        Optional<DiscountPeriod> one = discountPeriodReponsitory.findById(id);
        return one.orElse(null);
    }

    @Override
    public void delete(Integer id) {
        discountPeriodReponsitory.deleteById(id);
    }

    @Override
    public void add(DiscountPeriod discountPeriod) {
        discountPeriodReponsitory.save(discountPeriod);
    }

    @Override
    public void update(DiscountPeriod discountPeriod) {
        discountPeriodReponsitory.save(discountPeriod);
    }

    @Override
    public Page<DiscountPeriod> getDiscountPeriodsByStatus(int status, int page, int size) {
        return discountPeriodReponsitory.findByStatus(status, PageRequest.of(page, size));
    }

    @Override
    public void updatestatus() {
        List<DiscountPeriod> list = discountPeriodReponsitory.findAll();
        for (int i = 0; i < list.size(); i++) {
            LocalDate today = LocalDate.now();

            // Hiển thị ngày tháng năm theo định dạng
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String formattedDate = today.format(formatter);

        }
    }

    @Override
    public Page<DiscountPeriod> searchDiscountPeriods(String keyword,int page,int size) {
        return discountPeriodReponsitory.search(keyword,PageRequest.of(page,size));
    }

    @Override
    public List<DiscountPeriod> getDiscountPeriodsByStartDateBeforeAndEndDateAfter(String today ,double totalmoney) {
        return discountPeriodReponsitory.getDiscountPeriodsByStartDateBeforeAndEndDateAfter(today,totalmoney);
    }


}
