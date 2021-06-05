//
//  GraphViewExtenstion.swift
//  Jongp2
//
//  Created by junseok on 2021/06/01.
//

import Foundation
import Charts

extension GraphViewController{
    
    func setLineChart(){
        
        LineGraph = LineChartView()
        self.view.addSubview(LineGraph)
        LineGraph.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(SearchBtn.snp.bottom).offset(20)
        }
        
        LineGraph.noDataText = "데이터가 없습니다."
        LineGraph.noDataFont = .systemFont(ofSize: 20)
        LineGraph.noDataTextColor = .lightGray
        // 데이터 생성
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<xData.count {
            let dataEntry = ChartDataEntry(x: xData[i], y: yData[i])
            dataEntries.append(dataEntry)
        }
        
        let line1 = LineChartDataSet(entries: dataEntries, label: yLabel)
        line1.colors = [NSUIColor.blue]
        line1.lineWidth = 3.0
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        LineGraph.xAxis.labelPosition = .bottom
        LineGraph.rightAxis.enabled = false
        LineGraph.xAxis.setLabelCount(xData.count, force: false)
        
        //LineGraph.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
        LineGraph.xAxis.labelCount = 2 // x축에 label을 몇개 둘 것인가?
        
        LineGraph.chartDescription?.text = selectItem
        LineGraph.data = data
        LineGraph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setYearLineChart(){
        
        LineGraph = LineChartView()
        self.view.addSubview(LineGraph)
        LineGraph.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(SearchBtn.snp.bottom).offset(20)
        }
        
        LineGraph.noDataText = "데이터가 없습니다."
        LineGraph.noDataFont = .systemFont(ofSize: 20)
        LineGraph.noDataTextColor = .lightGray
        // 데이터 생성
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<xData.count {
            let dataEntry = ChartDataEntry(x: xData[i], y: yData[i])
            dataEntries.append(dataEntry)
        }
        
        var dataEntries2: [ChartDataEntry] = []
        for i in 0..<yData2.count {
            let dataEntry2 = ChartDataEntry(x: xData[i], y: yData2[i])
            dataEntries2.append(dataEntry2)
        }
        
        var dataEntries3: [ChartDataEntry] = []
        for i in 0..<yData3.count {
            let dataEntry3 = ChartDataEntry(x: xData[i], y: yData3[i])
            dataEntries3.append(dataEntry3)
        }
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .none
        formatter.locale = .current
        
        //평균 가격
        let line1 = LineChartDataSet(entries: dataEntries, label: yLabel)
        line1.colors = [NSUIColor.blue]
        line1.lineWidth = 3.0
        
        //생산량
        let line2 = LineChartDataSet(entries: dataEntries2, label: yLabel2)
        line2.colors = [NSUIColor.red]
        line2.lineWidth = 3.0
        
        //면적
        let line3 = LineChartDataSet(entries: dataEntries3, label: yLabel3)
        line3.colors = [NSUIColor.green]
        line3.valueFormatter = DefaultValueFormatter(formatter: formatter)
        line3.lineWidth = 3.0
        
        let data = LineChartData()
        data.addDataSet(line1)
        data.addDataSet(line2)
        data.addDataSet(line3)
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 0
        leftAxisFormatter.numberStyle = .none
        leftAxisFormatter.locale = .current
        
        LineGraph.xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        LineGraph.xAxis.labelPosition = .bottom
        LineGraph.rightAxis.enabled = false
        LineGraph.xAxis.setLabelCount(xData.count, force: true)
        
        LineGraph.chartDescription?.text = selectItem
        LineGraph.data = data
        LineGraph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setWeatherAndPriceChart(){
        
        LineGraph = LineChartView()
        self.view.addSubview(LineGraph)
        LineGraph.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalTo(SearchBtn.snp.bottom).offset(20)
        }
        
        LineGraph.noDataText = "데이터가 없습니다."
        LineGraph.noDataFont = .systemFont(ofSize: 20)
        LineGraph.noDataTextColor = .lightGray
        // 데이터 생성
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<xData.count {
            let dataEntry = ChartDataEntry(x: xData[i], y: yData[i])
            dataEntries.append(dataEntry)
        }
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .none
        formatter.locale = .current
        
        //평균 가격
        let line1 = LineChartDataSet(entries: dataEntries, label: yLabel)
        line1.colors = [NSUIColor.blue]
        line1.highlightEnabled = false
        line1.lineWidth = 3.0
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 0
        leftAxisFormatter.numberStyle = .none
        leftAxisFormatter.locale = .current

        // 줌 안되게
        LineGraph.doubleTapToZoomEnabled = true
        LineGraph.xAxis.labelCount = 5
        //LineGraph.xAxis.valueFormatter = self // label을 텍스트로 매칭
        LineGraph.xAxis.labelPosition = .bottom
        LineGraph.rightAxis.enabled = false
        LineGraph.xAxis.setLabelCount(xData.count, force: true)
        
        LineGraph.chartDescription?.text = selectItem
        LineGraph.data = data
        LineGraph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func GraphDataRequest(selectItem : String){
        if Item_dict[selectItem] == 0{
            getOilGraph(item : food_dict[selectFood]!, kind : kind_dict[selectKind]!, rank : rank_dict[selectRank]!)
        } else if Item_dict[selectItem] == 1{
            getYearGraph(item : food_dict[selectFood]!, kind : kind_dict[selectKind]!, rank : rank_dict[selectRank]!)
        } else if Item_dict[selectItem] == 2{
            getWeatherGraph(item : food_dict[selectFood]!, kind : kind_dict[selectKind]!, rank : rank_dict[selectRank]!, element: element_dict[selectElement]!)
        } else if Item_dict[selectItem] == 3{
            getPriceGraph(item : food_dict[selectFood]!, kind : kind_dict[selectKind]!, rank : rank_dict[selectRank]!, element: element_dict[selectElement]!)
        }
    }
    
    func getOilGraph(item : Int, kind : Int, rank : Int){
        print("\(WasURL.getURL(url:requestURL.graph_oil))?item=\(item)&kind=\(kind)&rank=\(rank)")
        
        getOilPrice(url : "\(WasURL.getURL(url:requestURL.graph_oil))?item=\(item)&kind=\(kind)&rank=\(rank)"){ [weak self] result in
            self?.xData.removeAll()
            self?.yData.removeAll()
            for i in 0..<result.oil_avgPrice_df.count{
                self?.xData.append(result.oil_avgPrice_df[i].oil_price)
                self?.yData.append(result.oil_avgPrice_df[i].avg_price)
            }
            
            DispatchQueue.main.async {
                self?.setLineChart()
            }
        }
    }
    
    func getYearGraph(item : Int, kind : Int, rank : Int){
        print("\(WasURL.getURL(url:requestURL.graph_year))?item=\(item)&kind=\(kind)&rank=\(rank)")
        
        getYearPrice(url : "\(WasURL.getURL(url:requestURL.graph_year))?item=\(item)&kind=\(kind)&rank=\(rank)"){ [weak self] result in
            self?.xData.removeAll()
            self?.yData.removeAll()
            self?.yData2.removeAll()
            self?.yData3.removeAll()
            
            for i in 0..<result.contents.count{
                self?.xData.append(Double(result.contents[i].year))
                
                self?.yData.append(Double(result.contents[i].output)!)
                self?.yData2.append(Double(result.contents[i].area)!)
                self?.yData3.append(result.contents[i].avg_price)
            }
            
            DispatchQueue.main.async {
                self?.setYearLineChart()
            }
        }
    }
    
    func getWeatherGraph(item : Int, kind : Int, rank : Int, element : Int){
        print("\(WasURL.getURL(url:requestURL.graph_weather))?item=\(item)&kind=\(kind)&rank=\(rank)&element=\(element)")
        
        getWeatherPrice(url : "\(WasURL.getURL(url:requestURL.graph_weather))?item=\(item)&kind=\(kind)&rank=\(rank)&element=\(element)"){ [weak self] result in
            self?.xData.removeAll()
            self?.yData.removeAll()
            
            for i in 0..<result.weather_avgPrice_df.count{
                self?.xData.append(Double(result.weather_avgPrice_df[i].element))
                self?.yData.append(result.weather_avgPrice_df[i].avg_price)
            }
            
            DispatchQueue.main.async {
                self?.setWeatherAndPriceChart()
            }
        }
    }
    
    func getPriceGraph(item : Int, kind : Int, rank : Int, element : Int){
        print("\(WasURL.getURL(url:requestURL.graph_price_index))?item=\(item)&kind=\(kind)&rank=\(rank)&element=\(element)")
        
        getPrice(url : "\(WasURL.getURL(url:requestURL.graph_price_index))?item=\(item)&kind=\(kind)&rank=\(rank)&element=\(element)"){ [weak self] result in
            self?.xData.removeAll()
            self?.yData.removeAll()
            
            for i in 0..<result.priceIndex_avgPrice_df.count{
                self?.xData.append(Double(result.priceIndex_avgPrice_df[i].element))
                self?.yData.append(result.priceIndex_avgPrice_df[i].avg_price)
            }
            
            DispatchQueue.main.async {
                self?.setWeatherAndPriceChart()
            }
        }
    }
}

//extension GraphViewController: IAxisValueFormatter {
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        let months = ["평균 기온", "평균 습도", "강수량", "평균 풍량"]
//        return months[Int(value)]
//    }
//}

struct oilContentList : Codable{
    let current_oil : Double!
    let oil_avgPrice_df : [oilContent]
}

struct oilContent : Codable {
    let oil_price : Double
    let avg_price : Double
}

struct yearContentList : Codable{
    let contents : [yearContent]
}

struct yearContent : Codable {
    let year : Int
    let area : String
    let output : String
    let avg_price : Double
}

struct weatherContentList : Codable{
    let current_weather : Int
    let weather_avgPrice_df : [weatherContent]
}

struct weatherContent : Codable{
    let element : Int
    let avg_price : Double
}


struct priceContentList : Codable{
    let current_priceIndex : Int
    let priceIndex_avgPrice_df : [priceContent]
}

struct priceContent : Codable{
    let element : Int
    let avg_price : Double
}
