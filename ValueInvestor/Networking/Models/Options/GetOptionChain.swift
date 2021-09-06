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
//    var id = UUID()
    let type: String?
    let expirationDate: String?
    let strike, lastPrice, bid, ask: Double?
    let change: Double?
    let changePercent: Double?
    let impliedVolatility, delta, gamma, theta: Double?
    let vega, rho, theoretical, intrinsicValue: Double?
    let daysBeforeExpiration: Int?
    let optionSymbol : String?
    let payedAsk : Double?
    let contractQuantity : Double?
    
    func updateOptionData(askPrice : Double, strickPrice : Double, stockSymbol : String, optionType : String, expirationDate : String, contractQuantity : Double) -> OptionData {
        return OptionData(type: optionType, expirationDate: expirationDate, strike: strickPrice, lastPrice: lastPrice, bid: bid, ask: ask, change: change, changePercent: changePercent, impliedVolatility: impliedVolatility, delta: delta, gamma: gamma, theta: theta, vega: vega, rho: rho, theoretical: theoretical, intrinsicValue: intrinsicValue, daysBeforeExpiration: daysBeforeExpiration, optionSymbol: stockSymbol, payedAsk: askPrice, contractQuantity: contractQuantity)
    }
    
    var optionValuePL : Double {
        let contractSize = contractQuantity ?? 1
        return ((contractSize * (ask ?? 0)) - (contractSize * (payedAsk ?? 0))) * 100

    }
    
    
    
}


