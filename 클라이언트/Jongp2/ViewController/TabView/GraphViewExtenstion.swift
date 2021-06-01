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
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        LineGraph.xAxis.labelPosition = .bottom
        LineGraph.rightAxis.enabled = false
        LineGraph.xAxis.setLabelCount(xData.count, force: false)
        
        if selectItem == "연도별 채소 생산량,면적,평균가" {
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
            
            let line2 = LineChartDataSet(entries: dataEntries2, label: yLabel2)
            line2.colors = [NSUIColor.red]
            
            let line3 = LineChartDataSet(entries: dataEntries3, label: yLabel3)
            line3.colors = [NSUIColor.green]
            data.addDataSet(line2)
            data.addDataSet(line3)
        }
        
        LineGraph.chartDescription?.text = selectItem
        LineGraph.data = data
        LineGraph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func makeGraph(){
        
    }
    
}
