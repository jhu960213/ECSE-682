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
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    lazy var stepChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        chartView.rightAxis.enabled = false
        chartView.largeContentTitle = "Steps vs Time"
        chartView.accessibilityLabel = "Lllll"
        let yAxis = chartView.leftAxis
        
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.axisMinimum = 0.0
        //        yAxis.setLabelCount(100, force: false)
        yAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        yAxis.axisLineColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        yAxis.labelPosition = .outsideChart
        if (liml != nil){
            liml?.lineColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            liml?.lineWidth = 2.5
            yAxis.addLimitLine(liml!)
        } //adding a goal limit line
        
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        //        chartView.xAxis.setLabelCount(100, force: false)
        chartView.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        chartView.xAxis.axisLineColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        chartView.xAxis.axisMinimum = 0
        chartView.animate(xAxisDuration: 2.5)
        chartView.setScaleEnabled(true) //can zoom in
        chartView.zoom(scaleX: 1.2, scaleY: 1, x: 50, y: 100)
        chartView.fitScreen()
        return chartView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stepChartView)
        
        stepChartView.centerInSuperview()
        //        stepChartView.width(350)
        //        stepChartView.height(550)
        stepChartView.width(to: view)
        //        stepChartView.heightToWidth(of: view)
        stepChartView.heightToWidth(of: view, multiplier: 1.40)
        setData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        stepChartView
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for n in 0...(stepValues.count-1){
            if (n>0){
                if ((n<stepValues.count)){//guard since data processes real time
                    if((stepValues[n].y < stepValues[n-1].y) || (stepValues[n].x<stepValues[n-1].x)){ //date processing
                        stepValues.remove(at: n)
                    }
                }
            }
            
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData(){
        stepsLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        self.view.bringSubviewToFront(stepsLabel);
        self.view.bringSubviewToFront(timeLabel);
        
        let lineDataSet = LineChartDataSet(entries: stepValues, label: "Steps")
        lineDataSet.mode = .cubicBezier
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.drawValuesEnabled = false
        lineDataSet.lineWidth = 3
        lineDataSet.setColor(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        
        let data = LineChartData(dataSet: lineDataSet)
        stepChartView.data = data
        
    }
}
