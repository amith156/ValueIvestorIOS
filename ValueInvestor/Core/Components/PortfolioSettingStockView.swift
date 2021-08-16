//
//  PortfolioSettingStockView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 15/08/2021.
//

import SwiftUI

struct PortfolioSettingStockView: View {
    
    let getResult : Result
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(getResult.symbol)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(getResult.regularMarketPrice.asNumberString())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 5) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (getResult.regularMarketChangePercent ?? 0) >= 0 ? 0 : 180))
                
                Text(getResult.regularMarketChangePercent?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((getResult.regularMarketChangePercent ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(getResult.regularMarketChangePercent == nil ? 0.0 : 1.0)
        }
        
    }
}

struct PortfolioSettingStockView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioSettingStockView(getResult: dev.result)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            PortfolioSettingStockView(getResult: dev.result)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
        }
    }
}
