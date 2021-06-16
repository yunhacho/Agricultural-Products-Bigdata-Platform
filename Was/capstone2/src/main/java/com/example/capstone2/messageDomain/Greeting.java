package com.example.capstone2.messageDomain;


import com.example.capstone2.domain.Record;
import com.example.capstone2.dto.StompDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Greeting {

    private StompDto Content;
}
