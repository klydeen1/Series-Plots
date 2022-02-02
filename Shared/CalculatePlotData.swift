//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    

    func plotYEqualsX()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        
        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        
        
        for i in 0 ..< 120 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

        //create y values here

        let y = x


            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
        
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }
    
    
    func ploteToTheMinusX()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10
        plotDataModel!.changingPlotParameters.yMin = -3.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -3.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y = exp(-x)"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "exp(-x)"

        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        for i in 0 ..< 60 {

            //create x values here
            let x = -2.0 + Double(i) * 0.2

            //create y values here
            let y = exp(-x)
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        return
    }
    
    func plotFiniteSumError() {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 0.1
        plotDataModel!.changingPlotParameters.yMin = -10.0
        plotDataModel!.changingPlotParameters.xMax = 6.5
        plotDataModel!.changingPlotParameters.xMin = -0.1
        plotDataModel!.changingPlotParameters.xLabel = "log(N)"
        plotDataModel!.changingPlotParameters.yLabel = "log(Relative error)"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "Log-log plot of relative error vs. number of terms for the series in Landau ch. 2.1.2 problem 2"

        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        
        @ObservedObject var sumModel = FiniteSum()
        for logN in stride(from: 0, through: 6, by: 0.01) {
            let N = Int(pow(10,logN))
            let relError = sumModel.calculateRelErrorS1(passedN: N)
            let y = Double(log10(Double(relError)))
            let x = Double(log10(Double(N)))
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        return
    }
    
    func plotSimpleSumError() {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = -13.0
        plotDataModel!.changingPlotParameters.yMin = -17.0
        plotDataModel!.changingPlotParameters.xMax = 6.5
        plotDataModel!.changingPlotParameters.xMin = -0.1
        plotDataModel!.changingPlotParameters.xLabel = "log(N)"
        plotDataModel!.changingPlotParameters.yLabel = "log(Relative error)"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "Log-log plot of relative error vs. number of terms for the series in Landau ch. 2.1.2 problem 3"

        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        
        @ObservedObject var sumModel = SimpleSeries()
        for logN in stride(from: 0, to: 6, by: 0.01) {
            let N = Int(pow(10,logN))
            let relError = sumModel.calculateRelError(passedN: N)
            let y = Double(log10(Double(relError)))
            let x = Double(log10(Double(N)))
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        return
    }
    
}



