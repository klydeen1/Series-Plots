//
//  ContentView.swift
//  Shared
//
//  Created by Jeff Terry on 12/17/20.
//  Modified by Katelyn Lydeen on 2/1/22.
//
//
//  Based on Code Created by Fred Appelman on 14/12/2020.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    @ObservedObject var plotDataModel = PlotDataClass(fromLine: true)
    @ObservedObject private var dataCalculator = CalculatePlotData()
    

    var body: some View {
        
        VStack{
      
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            
            HStack{
                Button("Plot log-log of relative error vs. number of terms", action: {self.calculateRelError()} )
                .padding()
                
                Button("Plot y = x", action: {self.calculateYEqualsX()} )
                .padding()
                
            }
        }
        
    }
    
    func calculateYEqualsX(){
        
        //pass the plotDataModel to the dataCalculator
        dataCalculator.plotDataModel = self.plotDataModel
        //Calculate the new plotting data and place in the plotDataModel
        dataCalculator.plotYEqualsX()
        
    }
    
    func calculateYEqualseToTheMinusX(){
        
        //pass the plotDataModel to the dataCalculator
        dataCalculator.plotDataModel = self.plotDataModel
        //Calculate the new plotting data and place in the plotDataModel
        dataCalculator.ploteToTheMinusX()
        
    }
    
    func calculateRelError() {
        //pass the plotDataModel to the dataCalculator
        dataCalculator.plotDataModel = self.plotDataModel
        //Calculate the new plotting data and place in the plotDataModel
        dataCalculator.plotFiniteSumError()
    }
    
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
