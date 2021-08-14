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
    @Published var statModelArray : [ETFModel] = [
        ETFModel(title: "SPY", value: "$700.4B", percentChange: 4.2),
        ETFModel(title: "QQQ", value: "$342.7B", percentChange: -3.7),
        ETFModel(title: "VIX", value: "$12.4B"),
        ETFModel(title: "Portfolio", value: "1.5M", percentChange: +42.3),
        ETFModel(title: "Portfolio", value: "1.5M", percentChange: +42.3),
    ]
    
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
        
        
        getQuotesService.$etfResult
            .map { resultArray -> [ETFModel] in
                
                var stats : [ETFModel] = []
                
                resultArray.forEach { result in
                    stats.append(ETFModel(title: result.symbol, value: result.regularMarketPrice.asCurrencyWith2Decimals(), percentChange: result.regularMarketChangePercent))
                }
                
                return stats
            }
            .sink { [weak self] etfModelArray in
                self?.statModelArray = etfModelArray
            }
            .store(in: &cancellable)
        
        
    }
    
    
}
