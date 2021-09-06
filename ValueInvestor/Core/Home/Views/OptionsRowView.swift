//
//  OptionsRowView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 30/08/2021.
//

import SwiftUI

struct OptionsRowView: View {
    
    let getOptionData : OptionData
    
    var body: some View {
        HStack {
            firstSection
            Spacer()
            secondSection
            Spacer()
            thirdSection
            Spacer()
            fourthSection
        }
    }
}

struct OptionsRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OptionsRowView(getOptionData: dev.optionData)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            OptionsRowView(getOptionData: dev.optionData)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
        }
        
    }
}

extension OptionsRowView {
    
    private var firstSection : some View {
        VStack(alignment: .leading) {
            Text("\(getOptionData.optionSymbol?.uppercased() ?? "")")
                .font(.headline)
//                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
            Text("\(getOptionData.expirationDate ?? "")")
                .font(.caption)
//                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
        
    }
    
    private var secondSection : some View {
        HStack {
            Text("\(Int(getOptionData.contractQuantity ?? 5))\(String(getOptionData.type?.first ?? "P") )")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
        
    }
    
    private var thirdSection : some View {
        VStack(alignment: .trailing) {
            Text("\(getOptionData.optionValuePL.asCurrencyWith2Decimals())")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
            Text("\((getOptionData.strike ?? 0).asCurrencyWith2Decimals()) @ \((getOptionData.payedAsk ?? 0).asNumberString())")
                .font(.caption)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
        
    }
    
    private var fourthSection : some View {
        VStack {
            Text("\(((getOptionData.ask ?? 0) * 100).asCurrencyWith2Decimals())")
                .font(.headline)
                .foregroundColor(Color.theme.accent)

        }
        .frame(width: UIScreen.main.bounds.width / 4, alignment: .trailing)
        
    }
    
}
