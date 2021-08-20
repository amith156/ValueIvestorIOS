//
//  DetailViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 20/08/2021.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let stockDetailDataService : StockDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(result: Result) {
        self.stockDetailDataService = StockDetailDataService(result: result)
        self.addSubscription()
    }
    
    private func addSubscription() {
        stockDetailDataService.$profile
            .sink { returnedSummary in
                print("summary ===> \(String(describing: returnedSummary?.symbol))")
            }.store(in: &cancellables)
    }
    
    
}
