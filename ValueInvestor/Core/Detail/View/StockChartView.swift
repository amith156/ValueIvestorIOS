//
//  StockChartView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 21/08/2021.
//

import SwiftUI

struct StockChartView: View {
    
    @StateObject var stockChartViewModel : StockChartViewModel
    @State var lineColour : Color = Color.theme.green
    @State private var percent : CGFloat = 0
    
    //    @State var minY : Double = 0
    //    @State var maxY : Double = 0
    //    @State var closingPrice : [Double] = [0]
    
    
    init(result : Result) {
        _stockChartViewModel = StateObject(wrappedValue: StockChartViewModel(result: result))
    }
    
    
    var body: some View {
        
        
        VStack {
            
            chartView
                .frame(height: 250)
                .background(chartBackground)
                .overlay(chartYAxisValues, alignment: .leading)
            

            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            
 
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.linear(duration: 2.5)) {
                    percent = 1.0
                }
            }
            
        }
        
        
    }
}

struct StockChartView_Previews: PreviewProvider {
    static var previews: some View {
        StockChartView(result: dev.result)
    }
}

extension StockChartView {
    
    private var chartView : some View {
        
        
        GeometryReader { geometry in
            Path { path in
                for index in stockChartViewModel.closingPrice.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(stockChartViewModel.closingPrice.count) * CGFloat(index + 1)
                    
                    //                    let yAxis = stockChartViewModel.closingPrice.max() - stockChartViewModel.closingPrice.min()
                    
                    let yAxis = (stockChartViewModel.closingPrice.max() ?? 0) - (stockChartViewModel.closingPrice.min() ?? 0)
                    
                    let yPosition = (1 - CGFloat((stockChartViewModel.closingPrice[index] - (stockChartViewModel.closingPrice.min() ?? 0)) / yAxis))  * geometry.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
                
            }
            .trim(from: 0, to: percent)
            .stroke((stockChartViewModel.priceDirection > 0 ? Color.theme.green : Color.theme.red), style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
            .shadow(color: (stockChartViewModel.priceDirection > 0 ? Color.theme.green : Color.theme.red), radius: 10, x: 0.0, y: 10)
            .shadow(color: (stockChartViewModel.priceDirection > 0 ? Color.theme.green : Color.theme.red).opacity(0.4), radius: 10, x: 0.0, y: 20)
            .shadow(color: (stockChartViewModel.priceDirection > 0 ? Color.theme.green : Color.theme.red).opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: (stockChartViewModel.priceDirection > 0 ? Color.theme.green : Color.theme.red).opacity(0.05), radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var chartBackground : some View {
        
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
        
    }
    
    private var chartYAxisValues : some View {
        VStack {
//            var maxY = stockChartViewModel.closingPrice.max() ?? 0
//            var minY = stockChartViewModel.closingPrice.min() ?? 0
            
            Text(stockChartViewModel.maxY.asCurrencyWith2Decimals())
            Spacer()
            Text((stockChartViewModel.median + ((stockChartViewModel.maxY + stockChartViewModel.minY)/6)).asCurrencyWith2Decimals())
            Spacer()
            Text((stockChartViewModel.median).asCurrencyWith2Decimals())
            Spacer()
            Text((stockChartViewModel.minY + (stockChartViewModel.median / 2)).asCurrencyWith2Decimals())
            Spacer()
            Text(stockChartViewModel.minY.asCurrencyWith2Decimals())
        }
    }
    
    
    private var chartXAxisValues : some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text("\(stockChartViewModel.initialTime)")
                Text("\(stockChartViewModel.initialDate)")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(stockChartViewModel.endTime)")
                Text("\(stockChartViewModel.endDate)")
                
            }
        }
        
    }
    
    
    
}
