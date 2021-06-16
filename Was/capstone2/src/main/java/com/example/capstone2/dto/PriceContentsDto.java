package com.example.capstone2.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class PriceContentsDto {

    private String timestamp;
    private String item_name;
    private String kind_name;
    private int price;
    private String rank;
    private String unit;
}
