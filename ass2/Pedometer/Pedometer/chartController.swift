//
//  chartController.swift
//  Pedometer
//
//  Created by Hamza Mian on 2020-10-17.
//

import UIKit
import CoreMotion
import Charts
import TinyConstraints

class chartController: UIViewController, ChartViewDelegate{
    
    lazy var stepChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        chartView.rightAxis.enabled = false
        chartView.largeContentTitle = "Steps vs Time"
        chartView.accessibilityLabel = "Lllll"
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
//        yAxis.setLabelCount(100, force: false)
        yAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        yAxis.axisLineColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        yAxis.labelPosition = .outsideChart

    
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
//        chartView.xAxis.setLabelCount(100, force: false)
        chartView.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        chartView.xAxis.axisLineColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stepChartView)
        stepChartView.centerInSuperview()
        stepChartView.width(to: view)
        stepChartView.heightToWidth(of: view)
        setData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData(){
        
        let lineDataSet = LineChartDataSet(entries: stepValues, label: "Steps")
        lineDataSet.mode = .cubicBezier
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.lineWidth = 3
        lineDataSet.setColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
//        lineDataSet.fill = Fill(color: (#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
//        lineDataSet.fillAlpha = 0.8
//        lineDataSet.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: lineDataSet)
        stepChartView.data = data
        
    }
}
