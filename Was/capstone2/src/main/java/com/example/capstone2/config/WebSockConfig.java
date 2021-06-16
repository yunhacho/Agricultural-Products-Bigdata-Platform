package com.example.capstone2.config;

import lombok.RequiredArgsConstructor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;


@RequiredArgsConstructor
@Configuration
@EnableWebSocket
@EnableWebSocketMessageBroker
public class WebSockConfig implements WebSocketMessageBrokerConfigurer {

    private static final Logger LOGGER = LogManager.getLogger(WebSockConfig.class);
    /***
     * 메시지 브포로커는 송신자에게 수신자의 이전 메시지 프로토콜로 변환해주는 모듈중 하나 요청이 오면 해당하는 통신 채널로 전송해주고 응답 역시 그대로 다시가서 안정적으로 메시지에 응답해주기위한 부분
     */
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry){
        /**
         * enableSimpleBroker = 클라이언트에게 메시지 응답할때 prefix 정의
         * setApplicationDestinationPrefixes = 클라이언트에서 메시지 송신할때 붙여줄 prefix 정의
         */
        //in-MEMORY message-broker, topic prefix설정
        registry.enableSimpleBroker("/sub"); //토파ㅣㄱ으로 오는게 들어오는곳
        registry.setApplicationDestinationPrefixes("/pub"); //발행자


    }

    /**
     * Stomp 엔드포인트가 노출이 되면 스프링은 스톰프 브로커가 된다.
     * @param registry
     */
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws").setAllowedOriginPatterns("*").withSockJS();
        //registry.addEndpoint().withSockJS();
    }
}
