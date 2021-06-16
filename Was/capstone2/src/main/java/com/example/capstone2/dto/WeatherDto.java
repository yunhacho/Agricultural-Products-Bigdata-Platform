package com.example.capstone2.dto;

import lombok.*;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class WeatherDto {

    private int current_weather;
    private List<WeatherContentsDto> weather_avgPrice_df;

}
