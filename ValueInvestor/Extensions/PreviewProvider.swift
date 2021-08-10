//
//  PreviewProvider.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 06/08/2021.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev : DeveloperPreview {
        return DeveloperPreview.instance
    }

    
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    //with private init, it restricts the creating of instace only in this class
    private init() {
        
    }
    
    let stockHomeViewModel = StockHomeViewModel()
    
    
    let result = Result(language: "en-US", region: "US", quoteType: "EQUITY", quoteSourceName: "Delayed Quote", triggerable: true, currency: "USD", firstTradeDateMilliseconds: 345479400000, priceHint: 2, totalCash: 6.1696E10, floatShares: 16513139929, ebitda: 110934999040, shortRatio: 1.14, preMarketChange: -0.119995, preMarketChangePercent: -0.0814299, preMarketTime: 1628083799, targetPriceHigh: 185.0, targetPriceLow: 125.0, targetPriceMean: 159.34, targetPriceMedian: 160.0, preMarketPrice: 147.24, heldPercentInsiders: 0.069, heldPercentInstitutions: 59.095, postMarketChangePercent: 0.040828552, postMarketTime: 1628121596, postMarketPrice: 147.01, postMarketChange: 0.05999756, regularMarketChange: -0.41000366, regularMarketChangePercent: -0.27823266, regularMarketTime: 1628107202, regularMarketPrice: 146.95, regularMarketDayHigh: 147.79, regularMarketDayRange: "146.28 - 147.79", regularMarketDayLow: 146.28, regularMarketVolume: 53941624, sharesShort: 96355309, sharesShortPrevMonth: 108937943, shortPercentFloat: 0.58, regularMarketPreviousClose: 147.36, bid: 146.9, ask: 146.94, bidSize: 14, askSize: 13, exchange: "NMS", market: "us_market", messageBoardID: "finmb_24937", fullExchangeName: "NasdaqGS", shortName: "Apple Inc.", longName: "Apple Inc.", regularMarketOpen: 147.27, averageDailyVolume3Month: 82650837, averageDailyVolume10Day: 78686600, beta: 1.20729, fiftyTwoWeekLowChange: 43.85, fiftyTwoWeekLowChangePercent: 0.42531523, fiftyTwoWeekRange: "103.1 - 150.0", fiftyTwoWeekHighChange: -3.050003, fiftyTwoWeekHighChangePercent: -0.020333353, fiftyTwoWeekLow: 103.1, fiftyTwoWeekHigh: 150.0, dividendDate: 1628726400, exDividendDate: 1628208000, earningsTimestamp: 1627403400, earningsTimestampStart: 1635332340, earningsTimestampEnd: 1635768000, trailingAnnualDividendRate: 0.835, trailingPE: 28.768599, pegRatio: 1.53, dividendsPerShare: 0.83, dividendRate: 0.88, trailingAnnualDividendYield: 0.005666395, dividendYield: 0.6, revenue: 3.47155005E11, priceToSales: 6.9971995, marketState: "POSTPOST", sharesOutstanding: 16530199552, bookValue: 3.882, fiftyDayAverage: 141.06914, fiftyDayAverageChange: 5.8808594, fiftyDayAverageChangePercent: 0.041687783, twoHundredDayAverage: 131.66992, twoHundredDayAverageChange: 15.280075, twoHundredDayAverageChangePercent: 0.116048336, marketCap: 2429112811520, forwardPE: 27.518724, priceToBook: 37.8542, sourceInterval: 15, exchangeDataDelayedBy: 0, exchangeTimezoneName: "America/New_York", exchangeTimezoneShortName: "EDT", pageViews: pageView, gmtOffSetMilliseconds: -14400000, esgPopulated: false, tradeable: false, epsTrailingTwelveMonths: 5.108, epsForward: 5.34, epsCurrentYear: 5.18, epsNextQuarter: 1.11, priceEpsCurrentYear: 28.368727, priceEpsNextQuarter: 132.38739, symbol: "AAPL", currentStockHoldings: 52)
    
}



let pageView = PageViews(midTermTrend: "UP", longTermTrend: "UP", shortTermTrend: "UP")


let quoteResponse = [Result(language: "en-US", region: "US", quoteType: "EQUITY", quoteSourceName: "Delayed Quote", triggerable: true, currency: "USD", firstTradeDateMilliseconds: 345479400000, priceHint: 2, totalCash: 6.1696E10, floatShares: 16513139929, ebitda: 110934999040, shortRatio: 1.14, preMarketChange: -0.119995, preMarketChangePercent: -0.0814299, preMarketTime: 1628083799, targetPriceHigh: 185.0, targetPriceLow: 125.0, targetPriceMean: 159.34, targetPriceMedian: 160.0, preMarketPrice: 147.24, heldPercentInsiders: 0.069, heldPercentInstitutions: 59.095, postMarketChangePercent: 0.040828552, postMarketTime: 1628121596, postMarketPrice: 147.01, postMarketChange: 0.05999756, regularMarketChange: -0.41000366, regularMarketChangePercent: -0.27823266, regularMarketTime: 1628107202, regularMarketPrice: 146.95, regularMarketDayHigh: 147.79, regularMarketDayRange: "146.28 - 147.79", regularMarketDayLow: 146.28, regularMarketVolume: 53941624, sharesShort: 96355309, sharesShortPrevMonth: 108937943, shortPercentFloat: 0.58, regularMarketPreviousClose: 147.36, bid: 146.9, ask: 146.94, bidSize: 14, askSize: 13, exchange: "NMS", market: "us_market", messageBoardID: "finmb_24937", fullExchangeName: "NasdaqGS", shortName: "Apple Inc.", longName: "Apple Inc.", regularMarketOpen: 147.27, averageDailyVolume3Month: 82650837, averageDailyVolume10Day: 78686600, beta: 1.20729, fiftyTwoWeekLowChange: 43.85, fiftyTwoWeekLowChangePercent: 0.42531523, fiftyTwoWeekRange: "103.1 - 150.0", fiftyTwoWeekHighChange: -3.050003, fiftyTwoWeekHighChangePercent: -0.020333353, fiftyTwoWeekLow: 103.1, fiftyTwoWeekHigh: 150.0, dividendDate: 1628726400, exDividendDate: 1628208000, earningsTimestamp: 1627403400, earningsTimestampStart: 1635332340, earningsTimestampEnd: 1635768000, trailingAnnualDividendRate: 0.835, trailingPE: 28.768599, pegRatio: 1.53, dividendsPerShare: 0.83, dividendRate: 0.88, trailingAnnualDividendYield: 0.005666395, dividendYield: 0.6, revenue: 3.47155005E11, priceToSales: 6.9971995, marketState: "POSTPOST", sharesOutstanding: 16530199552, bookValue: 3.882, fiftyDayAverage: 141.06914, fiftyDayAverageChange: 5.8808594, fiftyDayAverageChangePercent: 0.041687783, twoHundredDayAverage: 131.66992, twoHundredDayAverageChange: 15.280075, twoHundredDayAverageChangePercent: 0.116048336, marketCap: 2429112811520, forwardPE: 27.518724, priceToBook: 37.8542, sourceInterval: 15, exchangeDataDelayedBy: 0, exchangeTimezoneName: "America/New_York", exchangeTimezoneShortName: "EDT", pageViews: pageView, gmtOffSetMilliseconds: -14400000, esgPopulated: false, tradeable: false, epsTrailingTwelveMonths: 5.108, epsForward: 5.34, epsCurrentYear: 5.18, epsNextQuarter: 1.11, priceEpsCurrentYear: 28.368727, priceEpsNextQuarter: 132.38739, symbol: "AAPL", currentStockHoldings: 52)]


let getQuote = quoteResponse

