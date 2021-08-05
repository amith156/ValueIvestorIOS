//
//  GetQuotes.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 13/07/2021.
//

//import Foundation
//
//struct GetQuotes : Codable {
//
//
//    var quoteResponse : QuoteResponse?
//
//}
//
//struct QuoteResponse : Codable {
//
//    let result : [Result]?
//
//
//}
//
//struct Result : Codable {
//
////    var id = UUID()
//    let symbol: String?
//    let bid, ask: Double
//    let shortName : String?
//    let regularMarketChangePercent : Double?
//    let currentStockHoldings : Double?
//
//
//
//    enum CodingKeys: String, CodingKey {
//
//        case symbol
//        case ask = "ask"
//        case bid = "bid"
//        case shortName
//        case regularMarketChangePercent
//        case currentStockHoldings
//    }
//
//
//    var currentStockHoldingsValue: Double {
//        return (currentStockHoldings ?? 0) * bid
//    }
//}



import Foundation

// MARK: - GetQuotes
struct GetQuotes {
    let quoteResponse: QuoteResponse?
}

// MARK: - QuoteResponse
struct QuoteResponse {
    let result: [Result]?
}

// MARK: - Result
struct Result {
    let language, region, quoteType, quoteSourceName: String?
    let triggerable: Bool?
    let currency: String?
    let firstTradeDateMilliseconds, priceHint, totalCash, floatShares: Double?
    let ebitda: Double?
    let shortRatio, preMarketChange, preMarketChangePercent: Double?
    let preMarketTime, targetPriceHigh, targetPriceLow: Double?
    let targetPriceMean: Double?
    let targetPriceMedian: Double?
    let preMarketPrice, heldPercentInsiders, heldPercentInstitutions, postMarketChangePercent: Double?
    let postMarketTime: Double?
    let postMarketPrice, postMarketChange, regularMarketChange, regularMarketChangePercent: Double?
    let regularMarketTime: Double?
    let regularMarketPrice, regularMarketDayHigh: Double?
    let regularMarketDayRange: String?
    let regularMarketDayLow: Double?
    let regularMarketVolume, sharesShort, sharesShortPrevMonth: Double?
    let shortPercentFloat, regularMarketPreviousClose : Double?
    let bid, ask: Double
    let bidSize, askSize: Double?
    let exchange, market, messageBoardID, fullExchangeName: String?
    let shortName, longName: String?
    let regularMarketOpen: Double?
    let averageDailyVolume3Month, averageDailyVolume10Day: Double?
    let beta, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent: Double?
    let fiftyTwoWeekRange: String?
    let fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow: Double?
    let fiftyTwoWeekHigh, dividendDate, exDividendDate, earningsTimestamp: Double?
    let earningsTimestampStart, earningsTimestampEnd: Double?
    let trailingAnnualDividendRate, trailingPE, pegRatio, dividendsPerShare: Double?
    let dividendRate, trailingAnnualDividendYield, dividendYield: Double?
    let revenue: Double?
    let priceToSales: Double?
    let marketState: String?
    let sharesOutstanding: Double?
    let bookValue, fiftyDayAverage, fiftyDayAverageChange, fiftyDayAverageChangePercent: Double?
    let twoHundredDayAverage, twoHundredDayAverageChange, twoHundredDayAverageChangePercent: Double?
    let marketCap: Double?
    let forwardPE, priceToBook: Double?
    let sourceInterval, exchangeDataDelayedBy: Double?
    let exchangeTimezoneName, exchangeTimezoneShortName: String?
    let pageViews: PageViews?
    let gmtOffSetMilliseconds: Double?
    let esgPopulated, tradeable: Bool?
    let epsTrailingTwelveMonths, epsForward, epsCurrentYear, epsNextQuarter: Double?
    let priceEpsCurrentYear, priceEpsNextQuarter: Double?
    let symbol: String?
    let currentStockHoldings: Double?
    
    
    func updateHoldings(amount : Double) -> Result {
        return Result(language: language, region: region, quoteType: quoteType, quoteSourceName: quoteSourceName, triggerable: triggerable, currency: currency, firstTradeDateMilliseconds: firstTradeDateMilliseconds, priceHint: priceHint, totalCash: totalCash, floatShares: floatShares, ebitda: ebitda, shortRatio: shortRatio, preMarketChange: preMarketChange, preMarketChangePercent: preMarketChangePercent, preMarketTime: preMarketTime, targetPriceHigh: targetPriceHigh, targetPriceLow: targetPriceLow, targetPriceMean: targetPriceMean, targetPriceMedian: targetPriceMedian, preMarketPrice: preMarketPrice, heldPercentInsiders: heldPercentInsiders, heldPercentInstitutions: heldPercentInstitutions, postMarketChangePercent: postMarketChangePercent, postMarketTime: postMarketTime, postMarketPrice: postMarketPrice, postMarketChange: postMarketChange, regularMarketChange: regularMarketChange, regularMarketChangePercent: regularMarketChangePercent, regularMarketTime: regularMarketTime, regularMarketPrice: regularMarketPrice, regularMarketDayHigh: regularMarketDayHigh, regularMarketDayRange: regularMarketDayRange, regularMarketDayLow: regularMarketDayLow, regularMarketVolume: regularMarketVolume, sharesShort: sharesShort, sharesShortPrevMonth: sharesShortPrevMonth, shortPercentFloat: shortPercentFloat, regularMarketPreviousClose: regularMarketPreviousClose, bid: bid, ask: ask, bidSize: bidSize, askSize: askSize, exchange: exchange, market: market, messageBoardID: messageBoardID, fullExchangeName: fullExchangeName, shortName: shortName, longName: longName, regularMarketOpen: regularMarketOpen, averageDailyVolume3Month: averageDailyVolume3Month, averageDailyVolume10Day: averageDailyVolume10Day, beta: beta, fiftyTwoWeekLowChange: fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent: fiftyTwoWeekLowChangePercent, fiftyTwoWeekRange: fiftyTwoWeekRange, fiftyTwoWeekHighChange: fiftyTwoWeekHighChange, fiftyTwoWeekHighChangePercent: fiftyTwoWeekHighChangePercent, fiftyTwoWeekLow: fiftyTwoWeekLow, fiftyTwoWeekHigh: fiftyTwoWeekHigh, dividendDate: dividendDate, exDividendDate: exDividendDate, earningsTimestamp: earningsTimestamp, earningsTimestampStart: earningsTimestampStart, earningsTimestampEnd: earningsTimestampEnd, trailingAnnualDividendRate: trailingAnnualDividendRate, trailingPE: trailingPE, pegRatio: pegRatio, dividendsPerShare: dividendsPerShare, dividendRate: dividendRate, trailingAnnualDividendYield: trailingAnnualDividendYield, dividendYield: dividendYield, revenue: revenue, priceToSales: priceToSales, marketState: marketState, sharesOutstanding: sharesOutstanding, bookValue: bookValue, fiftyDayAverage: fiftyDayAverage, fiftyDayAverageChange: fiftyDayAverageChange, fiftyDayAverageChangePercent: fiftyDayAverageChangePercent, twoHundredDayAverage: twoHundredDayAverage, twoHundredDayAverageChange: twoHundredDayAverageChange, twoHundredDayAverageChangePercent: twoHundredDayAverageChangePercent, marketCap: marketCap, forwardPE: forwardPE, priceToBook: priceToBook, sourceInterval: sourceInterval, exchangeDataDelayedBy: exchangeDataDelayedBy, exchangeTimezoneName: exchangeTimezoneName, exchangeTimezoneShortName: exchangeTimezoneShortName, pageViews: pageViews, gmtOffSetMilliseconds: gmtOffSetMilliseconds, esgPopulated: esgPopulated, tradeable: tradeable, epsTrailingTwelveMonths: epsTrailingTwelveMonths, epsForward: epsForward, epsCurrentYear: epsCurrentYear, epsNextQuarter: epsNextQuarter, priceEpsCurrentYear: priceEpsCurrentYear, priceEpsNextQuarter: priceEpsNextQuarter, symbol: symbol, currentStockHoldings: amount)
    }
    
    
    var currentStockHoldingsValue: Double {
        return (currentStockHoldings ?? 0) * bid
    }
    
    
}

// MARK: - PageViews
struct PageViews {
    let midTermTrend, longTermTrend, shortTermTrend: String?
}

