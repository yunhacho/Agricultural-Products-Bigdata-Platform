package com.example.capstone2.controller;


import com.example.capstone2.dto.*;
import com.example.capstone2.service.SparkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@RestController
public class SparkController {


    private SparkService sparkService;

    @Autowired
    public SparkController(SparkService sparkService) {
        this.sparkService = sparkService;
    }


    @GetMapping("/show_price/days_before")
    public MappingJacksonValue priceBefore(@RequestParam("item") int item, @RequestParam("date") String date) throws IOException {


        Map<String, List<PriceContentsDto>> priceDtoResponseEntity = sparkService.price(item,false, date);

        HttpHeaders headers = new HttpHeaders();
        MappingJacksonValue mapping = new MappingJacksonValue(priceDtoResponseEntity);

        return mapping;

    }

    @GetMapping("/show_price/this_day")
    public MappingJacksonValue priceDay(@RequestParam("item") int item, @RequestParam("date") String date) throws IOException {
        Map<String, List<PriceContentsDto>> priceDtoResponseEntity = sparkService.price(item,true,date);

        HttpHeaders headers = new HttpHeaders();
        MappingJacksonValue mapping = new MappingJacksonValue(priceDtoResponseEntity);

        return mapping;
    }

    @GetMapping("/show_price/period")
    public MappingJacksonValue pricePeriod(@RequestParam("item") int item, @RequestParam("date1") String date1, @RequestParam("date2") String date2) throws IOException {
        Map<String, List<PriceContentsDto>> priceDtoResponseEntity = sparkService.pricePeriod(item,date1,date2);

        HttpHeaders headers = new HttpHeaders();
        MappingJacksonValue mappping = new MappingJacksonValue(priceDtoResponseEntity);
        return mappping;

    }
    @GetMapping("/show_graph/oil")
    public MappingJacksonValue priceOil(@RequestParam("item") int item, @RequestParam("kind") int kind, @RequestParam("rank") int rank) throws IOException {
        OilDto priceDtoResponseEntity = sparkService.oilPrice(item,kind,rank);

        HttpHeaders headers = new HttpHeaders();
        MappingJacksonValue mappping = new MappingJacksonValue(priceDtoResponseEntity);
        return mappping;

    }


    @GetMapping("/show_graph/year")
    public MappingJacksonValue priceYear(@RequestParam("item") int item, @RequestParam("kind") int kind, @RequestParam("rank") int rank) throws IOException {
        YearDto priceDtoResponseEntity = sparkService.yearPrice(item,kind,rank);

        HttpHeaders headers = new HttpHeaders();
        MappingJacksonValue mappping = new MappingJacksonValue(priceDtoResponseEntity);
        return mappping;

    }

    @GetMapping("/show_graph/weather")
    public MappingJacksonValue priceYear(@RequestParam("item") int item, @RequestParam("kind") int kind, @RequestParam("rank") int rank, @RequestParam("element") int element) throws IOException {
        WeatherDto priceDtoResponseEntity = sparkService.weatherPrice(item,kind,rank,element);

        HttpHeaders headers = new HttpHeaders();
        MappingJacksonValue mappping = new MappingJacksonValue(priceDtoResponseEntity);
        return mappping;

    }


    @GetMapping("/show_graph/price_index")
    public MappingJacksonValue priceAve(@RequestParam("item") int item, @RequestParam("kind") int kind, @RequestParam("rank") int rank, @RequestParam("element") int element) throws IOException {
        AvePriceDto priceDtoResponseEntity = sparkService.averagePrice(item,kind,rank,element);


        MappingJacksonValue mappping = new MappingJacksonValue(priceDtoResponseEntity);
        return mappping;

    }

    @GetMapping("/predict")
    public MappingJacksonValue priceAve(@RequestParam("item") int item, @RequestParam("kind") int kind, @RequestParam("rank") int rank) throws IOException {
        PredictDto priceDtoResponseEntity = sparkService.predictPrice(item,kind,rank);


        MappingJacksonValue mappping = new MappingJacksonValue(priceDtoResponseEntity);
        return mappping;

    }
}