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
    @Published var searchText : String = ""
    @Published var portfolioStocks : [Result] = []
    @Published var statModelArray : [ETFModel] = [
        ETFModel(title: "SPY", value: "$700.4B", percentChange: 4.2),
        ETFModel(title: "QQQ", value: "$342.7B", percentChange: -3.7),
        ETFModel(title: "VIX", value: "$12.4B"),
        ETFModel(title: "Portfolio", value: "1.5M", percentChange: +42.3),
        ETFModel(title: "Portfolio", value: "1.5M", percentChange: +42.3),
    ]
    
    
    
    private let getQuotesService = GetQuotesService()
    private var cancellable = Set<AnyCancellable>()
    private let portfolioDataService = PortfolioDataService()
//    private var getOptionChainService : GetOptionChainService
    
    init() {
//        self.getOptionChainService = GetOptionChainService(tickerSymbol: "")
        addSubscribers()
    }
    
    
    func addSubscribers() {

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
            .debounce(for: .seconds(0.75), scheduler: DispatchQueue.main)
            .combineLatest($searchText, getQuotesService.$searchResultArray, { resultArray, searchText, searchResultArray in
                
                print("resultArray count => \(resultArray.count)")
                
                
                if (resultArray.isEmpty) {
                    if (searchResultArray.isEmpty && !searchText.isEmpty) {
                        self.getQuotesService.getStockQuotesSearch(tickerSymbol: searchText)
                        print("hit!!!")
                    } else {
                        self.getQuotesService.searchResultArray = []
                    }
                    
                    print("\(searchResultArray.count) ---- \(resultArray.count) ***** if ******* \(searchText)")
                    return searchResultArray.filter { result in
                        
                        return true
                    }
                    
                    
                }
                else {
                    //                    self.getQuotesService.searchResultArray = []
                    return resultArray
                    print("\(resultArray) ***** else ****** \(searchText)")
                }
                print("#### count => \(resultArray.count) /////////////  \(searchText)")
                
                
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
        
        
//        portfolioDataService.$portfolioEntitySaved
//            .map { entity -> Int in
//
//                entity.map { entityItem in
//                    self.getQuotesService.downloadGetQuotesDB(tickerSymbols: entityItem.stockSymbol ?? "")
//                }
//                return 0
//            }
//            .sink { item in
//
//            }.store(in: &cancellable)
        
        
//        getQuotesService.$portfolioDB
//            .combineLatest(getQuotesService.$result)
//            .map { (db, result) -> () in
//
//
//                db.map { dbResult in
//
//                    if (result.contains(where: { result in
//                        return result.symbol == dbResult.symbol
//                    })) {
//
//                    } else {
//                        print("search stock => \(dbResult.symbol) ")
//                        self.getQuotesService.getStockQuotesSearch(tickerSymbol: dbResult.symbol)
//                    }
//
//
////                    let x = result.first { result in
////                        if dbResult.symbol == result.symbol {
////                            return false
////                        } else {
////                            return true
////                        }
////                    }
//
//                }
//            }
//            .sink { val in
//
//            }.store(in: &cancellable)
        
        
//        portfolioDataService.$portfolioEntitySaved
//            .combineLatest($portfolioStocks)
//            .debounce(for: .seconds(3) , scheduler: DispatchQueue.main)
//            .map { (entity, portfolio) in
//                var portArr : [PortfolioEntity] = []
//                
//                
//                let ent = entity.compactMap { ent in
//                    ent
//                }
//                
//                let pot = portfolio.compactMap { pot in
//                    pot
//                }
//                var returnList : [PortfolioEntity] = []
//                
//                ent.forEach { emt in
//                    var a = true
//                    pot.forEach { pot in
//                        if pot.symbol == emt.stockSymbol {
//                            a = false
//                        }
//                    }
//                    if a {
//                        returnList.append(emt)
//                    }
//                }
//                
//                returnList.forEach { list in
//                    self.getQuotesService.getStockQuotesSearch(tickerSymbol: list.stockSymbol!)
//                    print("item ===> \(list.stockSymbol)")
//                }
//                
//                
//            }.sink { () in
//                print("running")
//            }.store(in: &cancellable)
        
        
        
        $arrayStocks
            .combineLatest(portfolioDataService.$portfolioEntitySaved)
            .map { (result, portfolioEntities) -> [Result] in
                
                var resultReturn =
                    result.compactMap { currentResult -> Result? in
                        
                        guard let entity = portfolioEntities.first(where: { entity in
                            print("=====> \(entity.stockSymbol) ====== \(currentResult.symbol) \n")
                            return entity.stockSymbol == currentResult.symbol
                        }) else {
                            print("resultReturn =====> nil hit")
                            return nil
                        }
                        print("added = bang!!!!!")
                        //                        self.getQuotesService.getStockQuotesSearch(tickerSymbol: entity.stockSymbol!)
                        return currentResult.updateHoldings(amount: entity.currentHoldings, priceBought: entity.buyingStockPrice)
                    }
                
                
                return resultReturn
                
            }
            
//            .combineLatest(portfolioDataService.$portfolioEntitySaved,  <#T##transform: ([Result], Publisher.Output) -> T##([Result], Publisher.Output) -> T#>)
            .sink { [weak self] resultArray in
                print("-----> \(resultArray.count)")
                self?.portfolioStocks = resultArray
            }
            .store(in: &cancellable)
        
    }
    
    
    
    
    
    
    func updatePortfolio(stock: Result, amount: Double, buyingPrice : Double) {
        portfolioDataService.updatePortfolio(stock: stock, amount: amount, buyingPrice: buyingPrice)
    }
    
    
    func updateDB() {
        portfolioDataService.getPortfolio()
    }
    
}
