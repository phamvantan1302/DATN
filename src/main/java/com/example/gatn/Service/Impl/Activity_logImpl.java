package com.example.gatn.Service.Impl;

import com.example.gatn.Entity.ActivityLog;
import com.example.gatn.Repositoris.Activity_logReponsitory;
import com.example.gatn.Service.Activity_logService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class Activity_logImpl implements Activity_logService {

    @Autowired
    private Activity_logReponsitory activity_logReponsitory ;
    @Override
    public void add(ActivityLog activityLog) {
        activity_logReponsitory.save(activityLog);
    }

    @Override
    public Page<ActivityLog> getpageall(int page, int size) {
        return activity_logReponsitory.findAllByOrderByTimestampDesc(PageRequest.of(page,size));
    }
}
