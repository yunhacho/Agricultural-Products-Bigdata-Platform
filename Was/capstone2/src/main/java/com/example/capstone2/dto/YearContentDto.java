package com.example.capstone2.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class YearContentDto {

    private int area;
    private int output;
    private double avg_price;
    private int year;
}
