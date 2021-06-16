package com.example.capstone2.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class YearDto {
    private List<YearContentDto> contents;
}
