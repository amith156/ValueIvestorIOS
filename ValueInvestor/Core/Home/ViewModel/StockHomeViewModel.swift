//
//  StockHomeViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 09/08/2021.
//

import Foundation
import Combine
class StockHomeViewModel : ObservableObject {
    
    @Published var arrayStocks : [Result] = []
    @Published var portfolioStocks : [Result] = []
    
    private let getQuotesService = GetQuotesService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {
        getQuotesService.$result.sink { [weak self] resultArray in
            self?.arrayStocks = resultArray
            
        }
        .store(in: &cancellable)
    }
    
    
}
