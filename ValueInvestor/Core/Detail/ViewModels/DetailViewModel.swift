//
//  DetailViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 20/08/2021.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overViewStats : [ETFModel] = []
    @Published var ratioStats : [ETFModel] = []
    
    @Published var result : Result
    
    private let stockDetailDataService : StockDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(result: Result) {
        self.result = result
        self.stockDetailDataService = StockDetailDataService(result: result)
        self.addSubscription()
    }
    
    private func addSubscription() {
        
        stockDetailDataService.$profile
            .combineLatest($result)
            .map({ (profile, result) -> (overviewStats: [ETFModel], ratios: [ETFModel]) in
                
                
                //Overview
                let price = result.regularMarketPrice.asCurrencyWith2Decimals()
                let pricePrecentChange = result.regularMarketChangePercent
                let priceStat = ETFModel(title: "Price", value: price, percentChange: pricePrecentChange)
                
                let marketCap = profile?.summaryDetail?.marketCap?.fmt
                let mareketCapStat = ETFModel(title: "Market Cap", value: marketCap ?? "N/A")
                
                let dayLowPrice = profile?.price?.regularMarketDayLow?.raw?.asCurrencyWith2Decimals()
                let dayMarketLowStat = ETFModel(title: "Day Low", value: dayLowPrice ?? "N/A")
                
                let dayHighPrice = profile?.price?.regularMarketDayHigh?.raw?.asCurrencyWith2Decimals()
                let dayMarketHighStat = ETFModel(title: "Day High", value: dayHighPrice ?? "N/A")
                
                let revenu = profile?.calendarEvents?.earnings?.revenueAverage?.fmt
                let revenuStat = ETFModel(title: "Revenu", value: revenu ?? "N/A")
                
                
                //Ratios
                let priceEarning = result.trailingPE?.asCurrencyWith2Decimals()
                let priceEarningStat = ETFModel(title: "Price/Earnings Ratio", value: priceEarning ?? "N/A")
                
                let priceBook = result.priceToBook?.asCurrencyWith2Decimals()
                let priceBookStat = ETFModel(title: "Price/Book", value: priceBook ?? "N/A")
                
                let priceSales = result.priceToSales?.asCurrencyWith2Decimals()
                let priceSalesStat = ETFModel(title: "Price/Sales", value: priceSales ?? "N/A")
                
                let earningsPerSare = result.epsTrailingTwelveMonths?.asCurrencyWith2Decimals()
                let earningsPerSareStat = ETFModel(title: "Earnings/Share", value: earningsPerSare ?? "N/A")
                
                let bookValue = result.bookValue?.asNumberString()
                let bookValueStat = ETFModel(title: "Book Value", value: bookValue ?? "N/A")
                
                let dividentPerShare = result.dividendsPerShare?.asCurrencyWith2Decimals()
                let dividentPerShareStat = ETFModel(title: "Divident/Share", value: dividentPerShare ?? "N/A")
                
                let overview : [ETFModel] = [priceStat, mareketCapStat, dayMarketLowStat, dayMarketHighStat, revenuStat]
                let ratios : [ETFModel] = [priceEarningStat, priceBookStat, priceSalesStat, earningsPerSareStat, bookValueStat, dividentPerShareStat]
                
                return (overview,ratios)
            })
            .sink { [weak self] returnedStockDetail in
                
                self?.overViewStats = returnedStockDetail.overviewStats
                self?.ratioStats = returnedStockDetail.ratios
                
                
            }.store(in: &cancellables)
    }
    
    
}
