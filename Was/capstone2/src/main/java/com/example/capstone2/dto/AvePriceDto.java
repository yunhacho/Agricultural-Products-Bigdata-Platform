package com.example.capstone2.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AvePriceDto {

    private double current_priceIndex;
    private List<AvePriceContentsDto> priceIndex_avgPrice_df;
}
