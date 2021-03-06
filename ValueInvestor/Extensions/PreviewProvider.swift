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
    
//    let optionData = OptionData(type: "CALL", expirationDate: "2021-12-17", strike: 65, lastPrice: 81.02, bid: 83.55, ask: 86, change: 0.6, changePercent: 0.0075, impliedVolatility: 96.352, delta: 0.9649, gamma: 0.001, theta: -0.0254, vega: 0.0623, rho: 0.1198, theoretical: 84.775, intrinsicValue: 0, daysBeforeExpiration: 109, optionSymbol: "AAPL", contractSize: 2, payedAsk: 60)
    
    let optionData = OptionData(type: "CALL", expirationDate: "2021-12-17", strike: 65, lastPrice: 81.02, bid: 83.55, ask: 86, change: 0.6, changePercent: 0.0075, impliedVolatility: 96.352, delta: 0.9649, gamma: 0.001, theta: -0.0254, vega: 0.0623, rho: 0.1198, theoretical: 84.775, intrinsicValue: 0, daysBeforeExpiration: 109, optionSymbol: "AAPL", payedAsk: 60, contractQuantity: 2)
    
    
    
    let etf1 = ETFModel(title: "SPY", value: "$700.4B", percentChange: 4.2)
    let etf2 = ETFModel(title: "QQQ", value: "$342.7B", percentChange: -3.7)
    let etf3 = ETFModel(title: "VIX", value: "$12.4B")
    
    let stockHomeViewModel = StockHomeViewModel()
    
    
    let result = Result(language: "en-US", region: "US", quoteType: "EQUITY", quoteSourceName: "Delayed Quote", triggerable: true, currency: "USD", firstTradeDateMilliseconds: 345479400000, priceHint: 2, totalCash: 6.1696E10, floatShares: 16513139929, ebitda: 110934999040, shortRatio: 1.14, preMarketChange: -0.119995, preMarketChangePercent: -0.0814299, preMarketTime: 1628083799, targetPriceHigh: 185.0, targetPriceLow: 125.0, targetPriceMean: 159.34, targetPriceMedian: 160.0, preMarketPrice: 147.24, heldPercentInsiders: 0.069, heldPercentInstitutions: 59.095, postMarketChangePercent: 0.040828552, postMarketTime: 1628121596, postMarketPrice: 147.01, postMarketChange: 0.05999756, regularMarketChange: -0.41000366, regularMarketChangePercent: -0.27823266, regularMarketTime: 1628107202, regularMarketPrice: 146.95, regularMarketDayHigh: 147.79, regularMarketDayRange: "146.28 - 147.79", regularMarketDayLow: 146.28, regularMarketVolume: 53941624, sharesShort: 96355309, sharesShortPrevMonth: 108937943, shortPercentFloat: 0.58, regularMarketPreviousClose: 147.36, bid: 146.9, ask: 146.94, bidSize: 14, askSize: 13, exchange: "NMS", market: "us_market", messageBoardID: "finmb_24937", fullExchangeName: "NasdaqGS", shortName: "Apple Inc.", longName: "Apple Inc.", regularMarketOpen: 147.27, averageDailyVolume3Month: 82650837, averageDailyVolume10Day: 78686600, beta: 1.20729, fiftyTwoWeekLowChange: 43.85, fiftyTwoWeekLowChangePercent: 0.42531523, fiftyTwoWeekRange: "103.1 - 150.0", fiftyTwoWeekHighChange: -3.050003, fiftyTwoWeekHighChangePercent: -0.020333353, fiftyTwoWeekLow: 103.1, fiftyTwoWeekHigh: 150.0, dividendDate: 1628726400, exDividendDate: 1628208000, earningsTimestamp: 1627403400, earningsTimestampStart: 1635332340, earningsTimestampEnd: 1635768000, trailingAnnualDividendRate: 0.835, trailingPE: 28.768599, pegRatio: 1.53, dividendsPerShare: 0.83, dividendRate: 0.88, trailingAnnualDividendYield: 0.005666395, dividendYield: 0.6, revenue: 3.47155005E11, priceToSales: 6.9971995, marketState: "POSTPOST", sharesOutstanding: 16530199552, bookValue: 3.882, fiftyDayAverage: 141.06914, fiftyDayAverageChange: 5.8808594, fiftyDayAverageChangePercent: 0.041687783, twoHundredDayAverage: 131.66992, twoHundredDayAverageChange: 15.280075, twoHundredDayAverageChangePercent: 0.116048336, marketCap: 2429112811520, forwardPE: 27.518724, priceToBook: 37.8542, sourceInterval: 15, exchangeDataDelayedBy: 0, exchangeTimezoneName: "America/New_York", exchangeTimezoneShortName: "EDT", pageViews: pageView, gmtOffSetMilliseconds: -14400000, esgPopulated: false, tradeable: false, epsTrailingTwelveMonths: 5.108, epsForward: 5.34, epsCurrentYear: 5.18, epsNextQuarter: 1.11, priceEpsCurrentYear: 28.368727, priceEpsNextQuarter: 132.38739, symbol: "AAPL", currentStockHoldings: 52, buyingPrice: 10)
    
}



let pageView = PageViews(midTermTrend: "UP", longTermTrend: "UP", shortTermTrend: "UP")


let quoteResponse = [Result(language: "en-US", region: "US", quoteType: "EQUITY", quoteSourceName: "Delayed Quote", triggerable: true, currency: "USD", firstTradeDateMilliseconds: 345479400000, priceHint: 2, totalCash: 6.1696E10, floatShares: 16513139929, ebitda: 110934999040, shortRatio: 1.14, preMarketChange: -0.119995, preMarketChangePercent: -0.0814299, preMarketTime: 1628083799, targetPriceHigh: 185.0, targetPriceLow: 125.0, targetPriceMean: 159.34, targetPriceMedian: 160.0, preMarketPrice: 147.24, heldPercentInsiders: 0.069, heldPercentInstitutions: 59.095, postMarketChangePercent: 0.040828552, postMarketTime: 1628121596, postMarketPrice: 147.01, postMarketChange: 0.05999756, regularMarketChange: -0.41000366, regularMarketChangePercent: -0.27823266, regularMarketTime: 1628107202, regularMarketPrice: 146.95, regularMarketDayHigh: 147.79, regularMarketDayRange: "146.28 - 147.79", regularMarketDayLow: 146.28, regularMarketVolume: 53941624, sharesShort: 96355309, sharesShortPrevMonth: 108937943, shortPercentFloat: 0.58, regularMarketPreviousClose: 147.36, bid: 146.9, ask: 146.94, bidSize: 14, askSize: 13, exchange: "NMS", market: "us_market", messageBoardID: "finmb_24937", fullExchangeName: "NasdaqGS", shortName: "Apple Inc.", longName: "Apple Inc.", regularMarketOpen: 147.27, averageDailyVolume3Month: 82650837, averageDailyVolume10Day: 78686600, beta: 1.20729, fiftyTwoWeekLowChange: 43.85, fiftyTwoWeekLowChangePercent: 0.42531523, fiftyTwoWeekRange: "103.1 - 150.0", fiftyTwoWeekHighChange: -3.050003, fiftyTwoWeekHighChangePercent: -0.020333353, fiftyTwoWeekLow: 103.1, fiftyTwoWeekHigh: 150.0, dividendDate: 1628726400, exDividendDate: 1628208000, earningsTimestamp: 1627403400, earningsTimestampStart: 1635332340, earningsTimestampEnd: 1635768000, trailingAnnualDividendRate: 0.835, trailingPE: 28.768599, pegRatio: 1.53, dividendsPerShare: 0.83, dividendRate: 0.88, trailingAnnualDividendYield: 0.005666395, dividendYield: 0.6, revenue: 3.47155005E11, priceToSales: 6.9971995, marketState: "POSTPOST", sharesOutstanding: 16530199552, bookValue: 3.882, fiftyDayAverage: 141.06914, fiftyDayAverageChange: 5.8808594, fiftyDayAverageChangePercent: 0.041687783, twoHundredDayAverage: 131.66992, twoHundredDayAverageChange: 15.280075, twoHundredDayAverageChangePercent: 0.116048336, marketCap: 2429112811520, forwardPE: 27.518724, priceToBook: 37.8542, sourceInterval: 15, exchangeDataDelayedBy: 0, exchangeTimezoneName: "America/New_York", exchangeTimezoneShortName: "EDT", pageViews: pageView, gmtOffSetMilliseconds: -14400000, esgPopulated: false, tradeable: false, epsTrailingTwelveMonths: 5.108, epsForward: 5.34, epsCurrentYear: 5.18, epsNextQuarter: 1.11, priceEpsCurrentYear: 28.368727, priceEpsNextQuarter: 132.38739, symbol: "AAPL", currentStockHoldings: 52, buyingPrice: 5)]


let getQuote = quoteResponse

