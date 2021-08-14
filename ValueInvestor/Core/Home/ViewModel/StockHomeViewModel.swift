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
    @Published var searchText : String = ""
    
    private let getQuotesService = GetQuotesService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {
//        getQuotesService.$result.sink { [weak self] resultArray in
//            self?.arrayStocks = resultArray
//
//        }
//        .store(in: &cancellable)
        
        
        $searchText
            .combineLatest(getQuotesService.$result)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map({ (textSearch, stockArray) -> [Result] in
                
                guard !textSearch.isEmpty else {
                    return stockArray
                }
                
                return stockArray.filter { stockArr in
                    return stockArr.symbol.contains(textSearch) ||
                            stockArr.symbol.lowercased().contains(textSearch.lowercased())
                }
                
                
            })
            .sink { [weak self] newStock in
                self?.arrayStocks = newStock
            }
            .store(in: &cancellable)
        
    }
    
    
}
