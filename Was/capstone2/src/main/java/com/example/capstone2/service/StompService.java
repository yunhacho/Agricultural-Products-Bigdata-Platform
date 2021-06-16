package com.example.capstone2.service;


import com.example.capstone2.Repository.RecordRepository;
import com.example.capstone2.domain.Record;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@NoArgsConstructor
public class StompService {


    private RecordRepository repository;

    @Autowired
    public StompService(RecordRepository repository) {
        this.repository = repository;
    }

    public List<Record> findRecord() {
        List<Record> top10BybidtimeDesc = repository.findTop20ByOrderByBidtimeDesc();

        return top10BybidtimeDesc;

    }

}