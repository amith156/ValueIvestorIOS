//
//  StockHomeViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 09/08/2021.
//

import Foundation

class StockHomeViewModel : ObservableObject {
    
    @Published var arrayStocks : [Result] = []
    @Published var portfolioStocks : [Result] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.arrayStocks.append(DeveloperPreview.instance.result)
            self.portfolioStocks.append(DeveloperPreview.instance.result)
        }
    }
}
