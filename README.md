# Cloud Native 기반 농산물 빅데이터 플랫폼
![Build Status](https://img.shields.io/badge/language-Python3.7-g)  ![Build Status](https://img.shields.io/badge/language-Java11-pink) ![Build Status](https://img.shields.io/badge/langauge-Swift5-orange)
![Build Status](https://img.shields.io/badge/-MySQL-yellow) ![Build Status](https://img.shields.io/badge/Hadoop-Hdfs-lightgrey) ![Build Status](https://img.shields.io/badge/-SpringBoot-green) ![Build Status](https://img.shields.io/badge/Apache-kafka-purple) ![Build Status](https://img.shields.io/badge/Apache-Spark-red)
![Build Status](https://img.shields.io/badge/-STOMP-grey)  ![Build Status](https://img.shields.io/badge/-iOS-white)  ![Build Status](https://img.shields.io/badge/-Docker/kubernetes-blue)



## 배경 및 목적
  - 국내 농산물 생산액은 연간 32조원(2019년 기준), 도소매시장에서 거래되는 금액은 연간 100조원이 넘는다. 농산물 데이터가 여러 곳에 분산되어 있어 이를 통합하여 데이터를 제공하는 서비스가 부족하며, 물가 유가 날씨 등 다양한 요인에 영향을 많이 받는 농산물 가격 안정화에 기여하자는 목적으로 주제를 선정하였다. 다양한 곳에 흩어져 있는 농산물 데이터들을 한곳에 모아 하나의 플랫폼 구축하고 데이터들을 이용하여 농산물의 가격을 예측하고 시각화하는 서비스를 개발하기로 하였다. 
  - 클라우드 네이티브 컴퓨팅 환경로의 패러다임 변화에 따른 빅데이터 플랫폼 대응을 프로젝트 목표로 삼아 도커와 쿠버네티스를 활용해 농산물 빅데이터 플랫폼의 구성요소를 마이크로서비스로 구현하였다.
## 플랫폼 구성도
![전체구성도](https://user-images.githubusercontent.com/42794463/132098466-4694515b-d9c6-4f58-97e4-a3c0ee258f3d.png)

## 사용 데이터
일일 배치데이터 - 일일 단위로 수집
실시간 데이터(실시간경매속보서비스) - 24시간 실시간 수집
| 데이터명| 데이터 출처| 사용 목적 | 데이터 크기 |
| ----- | ----- | ----- | ----- |
| 일별 부류별 도.소매가격정보| 한국농수산식품유통공사 OPEN API| 작물 별 가격 예측 모델 변수 및 실시간 경매 데이터 일자별 가격 비교 | 약 200MB |
| 작물별 농업주산지 상세날씨 조회서비스 | 공공데이터 포털 OPEN API |작물별 가격예측 모델 변수 | 약 22MB |
| 유가 정보 API|오피넷 OPEN API 및 국내 유가 통계 |작물 별 가격 예측 모델 변수 | 약 2MB|
| 물가 상승률, 생산량, 재배면적| 국가통계포털 농작물생산조사, 농업면적조사, 소비자물가조사| 작물 별 가격 예측 모델 변수|물가상승률: 27.2KB생산량 및 재배면적: 67.4KB |
| 실시간 경매 속보 서비스 | 공공데이터포털 OPEN API| 실시간 경매 알림 서비스| 24시간 기준 약 88MB|
## iOS 클라이언트 
![Build Status](https://img.shields.io/badge/-SnapKit-green
) ![Build Status](https://img.shields.io/badge/-Alamofire-orange) ![Build Status](https://img.shields.io/badge/-StompClientLib-grey
) ![Build Status](https://img.shields.io/badge/-Charts-blue) ![Build Status](https://img.shields.io/badge/-NVActivityIndicatorView-darkgreen)
![ios](https://user-images.githubusercontent.com/42794463/132101478-974be3b5-36a9-4dbb-8d7d-47ce8abe2932.png)
