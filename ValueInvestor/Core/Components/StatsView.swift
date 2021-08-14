//
//  StatsView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 14/08/2021.
//

import SwiftUI

struct StatsView: View {
    
    let stat : ETFModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack(spacing: 5) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentChange == nil ? 0.0 : 1.0)
        
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatsView(stat: dev.etf1)
                .previewLayout(.sizeThatFits)
            StatsView(stat: dev.etf2)
                .previewLayout(.sizeThatFits)
            StatsView(stat: dev.etf3)
                .previewLayout(.sizeThatFits)
        }
    }
}
