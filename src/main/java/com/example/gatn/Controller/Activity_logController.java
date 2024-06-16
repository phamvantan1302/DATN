package com.example.gatn.Controller;

import com.example.gatn.Entity.ActivityLog;
import com.example.gatn.Entity.DiscountPeriod;
import com.example.gatn.Service.Activity_logService;
import com.example.gatn.Service.Impl.Activity_logImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("admin")
public class Activity_logController {
    @Autowired
    private Activity_logService activityLogService = new Activity_logImpl();

    @GetMapping("activitys")
    public ResponseEntity<Page<ActivityLog>> getallpage(@RequestParam int page, @RequestParam int size){
        Page<ActivityLog> paged= activityLogService.getpageall(page, size);
        return new ResponseEntity<>(paged, HttpStatus.OK);
    }
}
