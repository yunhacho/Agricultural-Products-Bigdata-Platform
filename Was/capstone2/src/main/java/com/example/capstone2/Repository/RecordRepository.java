package com.example.capstone2.Repository;


import com.example.capstone2.domain.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.domain.Sort;
@Repository
public interface RecordRepository extends JpaRepository<Record, LocalDateTime> {


   public List<Record> findTop20ByOrderByBidtimeDesc();
}
