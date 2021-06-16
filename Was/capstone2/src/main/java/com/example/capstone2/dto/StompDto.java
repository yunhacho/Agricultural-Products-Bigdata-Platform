package com.example.capstone2.dto;

import lombok.*;

import javax.persistence.Id;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StompDto {

    private String mclassname;

    private String sclassname;


    private String bidtime;


    private int price;
    private String gradename;
    private String marketname;
    private String coname;
    private String sanji;
    private int tradeamt;
    private String unitname;
}
