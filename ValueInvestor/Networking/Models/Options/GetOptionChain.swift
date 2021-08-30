//
//  GetOptionChain.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 28/08/2021.
//

import Foundation

// MARK: - GetOptionChain
struct GetOptionChain : Codable {
    let code, exchange, lastTradeDate: String?
    let lastTradePrice: Double?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum : Codable {
    let expirationDate: String?
    let impliedVolatility: Double?
    let putCallOpenInterestRatio: Double?
    let optionsCount: Int?
    let options: Options?
}

// MARK: - Options
struct Options : Codable {
    let call, put: [OptionData]?
    
    enum CodingKeys : String, CodingKey {
        case call = "CALL"
        case put = "PUT"
    }
}

// MARK: - Call
struct OptionData : Codable {
    let type: String?
    let expirationDate: String?
    let strike, lastPrice, bid, ask: Double?
    let change: Double?
    let changePercent: Double?
    let impliedVolatility, delta, gamma, theta: Double?
    let vega, rho, theoretical, intrinsicValue: Double?
    let daysBeforeExpiration: Int?
}


