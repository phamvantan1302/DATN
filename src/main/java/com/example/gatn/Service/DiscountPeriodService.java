package com.example.gatn.Service;



import com.example.gatn.Entity.DiscountPeriod;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;

public interface DiscountPeriodService {
    Page<DiscountPeriod> getpageall(int page,int size);

    DiscountPeriod getonebyid(Integer id);

    void delete(Integer id);

    void add(DiscountPeriod discountPeriod);

    void update(DiscountPeriod discountPeriod);

    Page<DiscountPeriod> getDiscountPeriodsByStatus(int status, int page, int size);

    void updatestatus();

    Page<DiscountPeriod> searchDiscountPeriods(String keyword,int page,int size);

    List<DiscountPeriod> getDiscountPeriodsByStartDateBeforeAndEndDateAfter(String today,double totalmoney);
}
