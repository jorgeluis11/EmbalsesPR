//
//  ViewController.swift
//  Embalses
//
//  Created by Jorge Perez on 9/28/15.
//  Copyright © 2015 Jorge Perez. All rights reserved.
//

import UIKit
import Kanna
import Charts

class DetailViewController: UIViewController {
    
    @IBOutlet var barChartView: BarChartView!
    var county:String?
    var date:String?
    var meters:String?
    
    @IBOutlet var labelWater: UILabel!
    var chartData = [899.56]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(meters)
        
        
     
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        let ll = ChartLimitLine(limit: 60, label: "Ajustes Operacionales")
        barChartView.rightAxis.addLimitLine(ll)
        
        let l2 = ChartLimitLine(limit: 80, label: "Obervación")
        barChartView.rightAxis.addLimitLine(l2)

        let l3 = ChartLimitLine(limit: 40, label: "Control")
        barChartView.rightAxis.addLimitLine(l3)
        
        let l4 = ChartLimitLine(limit: 20, label: "Fuera de Servicio")
        barChartView.rightAxis.addLimitLine(l4)
        
        let l5 = ChartLimitLine(limit: 120, label: "Seguridad")
        barChartView.rightAxis.addLimitLine(l5)
        
        let l6 = ChartLimitLine(limit: 180, label: "Desborde")
        barChartView.rightAxis.addLimitLine(l6)
        
        
        barChartView.noDataText = "You need to provide data for the chart."
//  
        var meterDouble:Double = Double(self.meters!)!
        let dataEntries: [BarChartDataEntry] = [BarChartDataEntry(value: meterDouble, xIndex: 0)]
        
//        for i in 0..<dataPoints.count {
//            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
//            dataEntries.append(dataEntry)
//        }
        
        print(dataEntries)
        
        let dataPoints2 = [self.county]
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: dataPoints2, dataSet: chartDataSet)
        barChartView.data = chartData
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {

        var newFrame:CGRect = labelWater.frame;
        newFrame.origin.y = newFrame.origin.y - 615;
//        newFrame.size.height = 181;
        
        newFrame.size.height = 665;
        UIView.animateWithDuration(3, animations: {
            self.labelWater.frame = newFrame
        })
    }


}

