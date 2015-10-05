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
    var niveles:[Double]?
    
    @IBOutlet var labelWater: UILabel!
    var chartData = [899.56]
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBAction func backButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        print("Sdf")
    }
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationBar.ba = backButton
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        if let niveles = niveles{
            
            var ll = ChartLimitLine(limit: niveles[0], label: "Desborde")
            
//            ll.setLineColor(Color.RED);
//            
//        
//                        ll.setLineWidth(4f);
//                        ll.setTextColor(Color.BLACK);
//                        ll.setTextSize(12f);

            barChartView.rightAxis.addLimitLine(ll)
            
            barChartView.rightAxis.addLimitLine(ChartLimitLine(limit: niveles[1], label: "Seguridad"))
            
            barChartView.rightAxis.addLimitLine(ChartLimitLine(limit: niveles[2], label: "Obervación"))
            
            barChartView.rightAxis.addLimitLine(ChartLimitLine(limit: niveles[3], label: "Ajustes Operacionales"))
            
            barChartView.rightAxis.addLimitLine(ChartLimitLine(limit: niveles[4], label: "Control"))
            
//            var xAxis:ChartYAxis = barChartView.getAxis(ChartYAxis(position: 34.34))
//            LimitLine ll = new LimitLine(140f, "Critical Blood Pressure");
//            ll.setLineColor(Color.RED);
//            ll.setLineWidth(4f);
//            ll.setTextColor(Color.BLACK);
//            ll.setTextSize(12f);
            // .. and more styling options
//            
//            leftAxis.addLimitLine(ll);
        }
        
        
        
        barChartView.noDataText = "You need to provide data for the chart."
        let meterDouble:Double = Double(self.meters!)!
        let dataEntries: [BarChartDataEntry] = [BarChartDataEntry(value: meterDouble, xIndex: 0)]
        
        let dataPoints2 = [self.county]
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Agua en Metros")
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

