package com.example.capstone2.service;

import com.example.capstone2.dto.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class SparkService {

    @Value("${host.desktop}")
    private String host;



    /** 특정 날짜 및 날짜 기준 이전 데이터
     * @param date = "검색 시작 일자 , 검색 종료 일자 가변인자 형태"
     * @param flag = "구간 검색여부, 특정 날짜 검색 여부 flag"
     * @param item = "검색 종목"
     */

    public Map<String, List<PriceContentsDto>> price(int item, boolean flag, String date) throws IOException {
        StringBuffer sb = new StringBuffer(host);
        sb.append("show_price/");




        if (flag)
            sb.append("this_day");
        else
            sb.append("days_before");

        UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(sb.toString())
                .queryParam("item", item)
                .queryParam("date", date).build(false);

        RestTemplate template = makeTemplate();

        ResponseEntity response = template.exchange(uriComponents.toUriString(), HttpMethod.GET, null,String.class);




        return priceMapping((String) response.getBody());

    }

    /**
     * 기간 가격 데이터
     * @param item
     * @param date1
     * @param date2
     * @return
     * @throws IOException
     */
    public Map<String,List<PriceContentsDto>> pricePeriod(int item, String date1,String date2) throws IOException {
        String baseUrl = host + "show_price/period";


        UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("item",item)
                .queryParam("date1",date1)
                .queryParam("date2",date2).build(false);



        RestTemplate template = makeTemplate();

        ResponseEntity response = template.exchange(uriComponents.toUriString(), HttpMethod.GET, null, String.class);
        System.out.println(response.getBody());

        return priceMapping((String) response.getBody());

    }

    /**
     * 유가별 채소 변동 그래프
     * @param item
     * @param kind
     * @param rank
     * @return
     * @throws IOException
     */

    public OilDto oilPrice(int item, int kind, int rank) throws IOException {

        String baseUrl = host + "show_graph/oil";
        UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("item",item)
                .queryParam("kind",kind)
                .queryParam("rank",rank).build(false);



        RestTemplate template = makeTemplate();

        ResponseEntity response = template.exchange(uriComponents.toUriString(), HttpMethod.GET, null, String.class);

        ObjectMapper mapper = new ObjectMapper();
        Map<String,Object> map= mapper.readValue((String) response.getBody(), Map.class);

        OilDto oilDto = OilDto.builder()
                        .current_oil((Double) map.get("current_oil"))
                        .oil_avgPrice_df((List<OilContentsDto>) map.get("oil_avgPrice_df"))
                        .build();


        return oilDto;


    }


    /**
     * 연도에 따른 채소 생산량
     *
     * @param item
     * @param kind
     * @param rank
     * @return
     * @throws IOException
     */
    public YearDto yearPrice(int item, int kind, int rank) throws IOException {

        String baseUrl = host + "show_graph/year";
        UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("item",item)
                .queryParam("kind",kind)
                .queryParam("rank",rank).build(false);



        RestTemplate template = makeTemplate();

        ResponseEntity response = template.exchange(uriComponents.toUriString(), HttpMethod.GET, null, String.class);

        ObjectMapper mapper = new ObjectMapper();
        Map<String,Object> map= mapper.readValue((String) response.getBody(), Map.class);

        YearDto yearDto = YearDto.builder().contents((List<YearContentDto>) map.get("contents")).build();


        return yearDto;


    }


    /**
     * 평균기온및습도에따른 채소 가격 변동 그래프
     *
     * @param item
     * @param kind
     * @param rank
     * @return
     * @throws IOException
     */
    public WeatherDto weatherPrice(int item, int kind, int rank, int element) throws IOException {

        String baseUrl = host + "show_graph/weather";
        UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("item",item)
                .queryParam("kind",kind)
                .queryParam("rank",rank)
                .queryParam("element",element).build(false);



        RestTemplate template = makeTemplate();

        ResponseEntity response = template.exchange(uriComponents.toUriString(), HttpMethod.GET, null, String.class);

        ObjectMapper mapper = new ObjectMapper();
        Map<String,Object> map= mapper.readValue((String) response.getBody(), Map.class);

        WeatherDto weatherDto = WeatherDto.builder()
                                .current_weather((int) map.get("current_weather"))
                                .weather_avgPrice_df((List<WeatherContentsDto>) map.get("weather_avgPrice_df")).build();


        return weatherDto;


    }

    /**
     * 곡물 및 식량 물가에따른 변동 그래프
     *
     * @param item
     * @param kind
     * @param rank
     * @return
     * @throws IOException
     */
    public AvePriceDto averagePrice(int item, int kind, int rank, int element) throws IOException {

        String baseUrl = host + "show_graph/price_index";
        UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("item",item)
                .queryParam("kind",kind)
                .queryParam("rank",rank)
                .queryParam("element",element).build(false);



        RestTemplate template = makeTemplate();

        ResponseEntity response = template.exchange(uriComponents.toUriString(), HttpMethod.GET, null, String.class);

        ObjectMapper mapper = new ObjectMapper();
        Map<String,Object> map= mapper.readValue((String) response.getBody(), Map.class);

        AvePriceDto avePriceDto = AvePriceDto.builder()
                .current_priceIndex((double) map.get("current_priceIndex"))
                .priceIndex_avgPrice_df((List<AvePriceContentsDto>) map.get("priceIndex_avgPrice_df")).build();


        return avePriceDto;


    }

    /**
     * 급등 급락 예측
     *
     * @param item
     * @param kind
     * @param rank
     * @return
     * @throws IOException
     */
    public PredictDto predictPrice(int item, int kind, int rank) throws IOException {

        String baseUrl = host + "predict";
        UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("item",item)
                .queryParam("kind",kind)
                .queryParam("rank",rank).build(false);



        RestTemplate template = makeTemplate();

        ResponseEntity response = template.exchange(uriComponents.toUriString(), HttpMethod.GET, null, String.class);

        ObjectMapper mapper = new ObjectMapper();
        Map<String,Object> map= mapper.readValue((String) response.getBody(), Map.class);

        PredictDto predictDto = PredictDto.builder()
                .predict_price((String) map.get("predict_price")).build();


        return predictDto;


    }

    private RestTemplate makeTemplate() {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application","json", Charset.forName("UTF-8")));

        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setConnectTimeout(30000);
        factory.setReadTimeout(30000);

        return new RestTemplate(factory);
    }


    private ConcurrentHashMap<String, List<PriceContentsDto>> priceMapping(String Value) throws IOException {

        ObjectMapper mapper = new ObjectMapper();

        ConcurrentHashMap<String, List<PriceContentsDto>> map = mapper.readValue(Value, ConcurrentHashMap.class);


        return map;

    }

}
