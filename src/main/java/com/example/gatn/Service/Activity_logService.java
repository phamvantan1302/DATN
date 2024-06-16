package com.example.gatn.Service;

import com.example.gatn.Entity.ActivityLog;
import com.example.gatn.Entity.DiscountPeriod;
import org.springframework.data.domain.Page;

public interface Activity_logService {
    void add(ActivityLog activityLog);
    Page<ActivityLog> getpageall(int page, int size);
}
