//
//  GetChart.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 21/08/2021.
//

import Foundation

struct GetChart : Codable {
    let chart: Chart?
}

// MARK: - Chart
struct Chart : Codable {
    let result: [ChartResult]?
}

// MARK: - Result
struct ChartResult : Codable {
    let meta: Meta?
    let timestamp: [Double]?
    let indicators: Indicators?
}

// MARK: - Indicators
struct Indicators : Codable {
    let quote: [Quote]?
}

// MARK: - Quote
struct Quote : Codable {
    let close: [Double]
}

// MARK: - Meta
struct Meta : Codable {
    let symbol: String?
    let firstTradeDate, regularMarketTime, gmtoffset: Int?
    let timezone, exchangeTimezoneName: String?
    let regularMarketPrice, chartPreviousClose, previousClose: Double?
    let dataGranularity, range: String?
}
