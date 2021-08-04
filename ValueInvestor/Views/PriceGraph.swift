//
//  PriceGraph.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 16/07/2021.
//

import SwiftUI
import SwiftUICharts

struct PriceGraph: View {
    
    
    public static let barChartStyleNeonBlueDark = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    
    var body: some View {
        
        VStack {
            LineView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], style: PriceGraph.barChartStyleNeonBlueDark, valueSpecifier: "%.1f", legendSpecifier: "%.2f")
                .ignoresSafeArea()
                .frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: UIScreen.main.bounds.size.height/3)
            


        }
        
        
    }
}

struct PriceGraph_Previews: PreviewProvider {
    static var previews: some View {
        PriceGraph()
    }
}
