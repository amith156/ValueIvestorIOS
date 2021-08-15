//
//  PortfolioSettingView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 15/08/2021.
//

import SwiftUI

struct PortfolioSettingView: View {
    
    @EnvironmentObject private var stockHomeViemModel : StockHomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBarView(searchText: $stockHomeViemModel.searchText)
                }
            }.navigationTitle("Add Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButtonView()
                }
            })
        }
    }
}

struct PortfolioSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSettingView()
            .environmentObject(dev.stockHomeViewModel)
    }
}
