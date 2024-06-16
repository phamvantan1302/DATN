package com.example.gatn.Repositoris;

import com.example.gatn.Entity.ActivityLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Activity_logReponsitory extends JpaRepository<ActivityLog,Integer> {
    Page<ActivityLog> findAllByOrderByTimestampDesc(Pageable pageable);
}
