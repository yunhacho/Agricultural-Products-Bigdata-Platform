package com.example.capstone2.controller;


import com.example.capstone2.domain.Record;
import com.example.capstone2.dto.PredictDto;
import com.example.capstone2.dto.StompDto;
import com.example.capstone2.messageDomain.Greeting;
import com.example.capstone2.service.StompService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.swing.plaf.basic.BasicMenuUI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@RestController
public class StompController {

    private SimpMessagingTemplate simpMessagingTemplate;

    private static final Logger LOGGER = LogManager.getLogger(StompController.class);


    private StompService stompService;

    @Autowired
    public StompController(StompService stompService) {
        this.stompService = stompService;
    }



    @MessageMapping("/test")
    @SendTo("/sub/user")
    public Greeting message(String message) throws JsonProcessingException {
        //LOGGER.debug("호출 메시지 테스트");
        //Map<String, Record> map = new HashMap<>();
        System.out.println(message);

        String json = message.replace("'","\"");

        System.out.println(json);
        ObjectMapper mapper = new ObjectMapper();
        StompDto stompDto = mapper.readValue(json, StompDto.class);


        return new Greeting(stompDto);


    }



    @GetMapping("/record")
    public ResponseEntity<Map<String,List<Record>>> callRecord() {
        List<Record> record = stompService.findRecord();
//        for(Record temp : record)
//            System.out.println(temp);
        HttpHeaders headers = new HttpHeaders();

        Map<String, List<Record>> map = new ConcurrentHashMap<>();
        map.put("contents", record);
        return new ResponseEntity<>(map,headers,HttpStatus.OK);

    }



}
