//
//  ETFStatRow.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 14/08/2021.
//

import SwiftUI

struct ETFStatRow: View {
    
    @Binding var showNextPageStat : Bool
    @EnvironmentObject private var stockHomeViewModel : StockHomeViewModel
    
    
    var body: some View {
        HStack {
            ForEach(stockHomeViewModel.statModelArray) { stat in
                StatsView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showNextPageStat ? .trailing : .leading)
        .padding(.horizontal)
    }
}

struct ETFStatRow_Previews: PreviewProvider {
    static var previews: some View {
        ETFStatRow(showNextPageStat: .constant(false))
            .environmentObject(dev.stockHomeViewModel)
        
    }
}
