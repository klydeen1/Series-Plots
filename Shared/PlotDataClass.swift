//
//  PlotDataClass.swift
//  SwiftUICorePlotExample
//  Shared
//
//  Created by Jeff Terry on 12/16/20.
//

import Foundation
import SwiftUI
import CorePlot

class PlotDataClass: NSObject, ObservableObject {
    
    @Published var plotData = [plotDataType]()
    @Published var changingPlotParameters: ChangingPlotParameters = ChangingPlotParameters()
    
    //In case you want to plot vs point number
    @Published var pointNumber = 1.0
    
    init(fromLine line: Bool) {
        
        
        //Must call super init before initializing plot
        super.init()
       
        
        //Intitialize the first plot
        self.plotYEqualsX()
        
       }
    
    
    
    func plotYEqualsX()
    {
        plotData = []
        
        
        for i in 0 ..< 120 {
            //create x values here
            let x = -2.0 + Double(i) * 0.2

            //create y values here
            let y = x

            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(dataPoint)
        
        }
        
        //set the Plot Parameters
        changingPlotParameters.yMax = 4.0
        changingPlotParameters.yMin = -1.0
        changingPlotParameters.xMax = 4.0
        changingPlotParameters.xMin = -1.0
        changingPlotParameters.xLabel = "x"
        changingPlotParameters.yLabel = "y"
        changingPlotParameters.lineColor = .red()
        changingPlotParameters.title = " y = x"
        
    }
    
    func plotFiniteSumError() {
        plotData = []
        @ObservedObject var sumModel = FiniteSum()
        for logN in stride(from: 0, through: 6, by: 0.01) {
            let N = Int(pow(10,logN))
            let relError = sumModel.calculateRelErrorS1(passedN: N)
            let y = Double(log10(Double(relError)))
            let x = Double(log10(Double(N)))
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(dataPoint)
        }
        // Set the Plot Parameters
        changingPlotParameters.yMax = 0.1
        changingPlotParameters.yMin = -10.0
        changingPlotParameters.xMax = 6.5
        changingPlotParameters.xMin = -0.1
        changingPlotParameters.xLabel = "log(N)"
        changingPlotParameters.yLabel = "log(Relative error)"
        changingPlotParameters.lineColor = .red()
        changingPlotParameters.title = "Log-log plot of relative error vs. number of terms for the series in Landau ch. 2.1.2 problem 2"
    }
    
    func plotSimpleSumError() {
        plotData = []
        @ObservedObject var sumModel = SimpleSeries()
        for logN in stride(from: 0, through: 6, by: 0.01) {
            let N = Int(pow(10,logN))
            let relError = sumModel.calculateRelError(passedN: N)
            let y = log10(Double(relError))
            let x = log10(Double(N))
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(dataPoint)
        }
        // Set the Plot Parameters
        changingPlotParameters.yMax = -13.0
        changingPlotParameters.yMin = -17.0
        changingPlotParameters.xMax = 6.5
        changingPlotParameters.xMin = -0.1
        changingPlotParameters.xLabel = "log(N)"
        changingPlotParameters.yLabel = "log(Relative error)"
        changingPlotParameters.lineColor = .red()
        changingPlotParameters.title = "Log-log plot of relative error vs. number of terms for the series in Landau ch. 2.1.2 problem 3"
    }
    
    func zeroData(){
            
            plotData = []
            pointNumber = 1.0
            
        }
        
        func appendData(dataPoint: [plotDataType])
        {
          
            plotData.append(contentsOf: dataPoint)
            pointNumber += 1.0
            
            
            
        }
}


