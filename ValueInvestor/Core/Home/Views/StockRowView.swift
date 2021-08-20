//
//  StockRowView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 08/08/2021.
//

import SwiftUI

struct StockRowView: View {
    
    let getResult : Result
    let showHoldingsColumn : Bool
    
    var body: some View {
        HStack {
            
            columnLeft
            
            Spacer()
            
            if showHoldingsColumn {
                columnCenter
            }
            
            columnRight
            
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct StockRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockRowView(getResult: dev.result, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            StockRowView(getResult: dev.result, showHoldingsColumn: true)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}



extension StockRowView {
    
    
    private var columnLeft : some View {
        Text("\(getResult.symbol.uppercased())")
            .font(.headline)
            .padding(.leading, 6)
            .foregroundColor(Color.theme.accent)
    }
    
    
    private var columnCenter : some View {
        VStack(alignment: .trailing) {
            Text(getResult.currentStockHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((getResult.currentStockHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    
    
    private var columnRight : some View {
        VStack(alignment: .trailing) {
            
            Text(getResult.regularMarketPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            
            Text(getResult.regularMarketChangePercent?.asPercentString() ?? "")
                .foregroundColor(
                    (getResult.regularMarketChangePercent ?? 0) >= 0 ?
                        Color.theme.green : Color.theme.red
                
                )
            
        }
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
    }
    
}
