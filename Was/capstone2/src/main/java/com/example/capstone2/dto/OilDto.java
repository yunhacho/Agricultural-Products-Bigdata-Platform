package com.example.capstone2.dto;

import lombok.*;

import java.util.List;
import java.util.Map;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class OilDto {
    public Double  current_oil;
    public List<OilContentsDto> oil_avgPrice_df;


}
