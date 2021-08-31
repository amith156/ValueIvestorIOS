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
    let stockSymbol : String?
    let contractSize : Double?
    let payedAsk : Double?
    
    
    func updateOptionData(askPrice : Double, strickPrice : Double, stockSymbol : String, optionType : String, expirationDate : String, contractSize : Double) -> OptionData {
        return OptionData(type: optionType, expirationDate: expirationDate, strike: strickPrice, lastPrice: lastPrice, bid: bid, ask: ask, change: change, changePercent: changePercent, impliedVolatility: impliedVolatility, delta: delta, gamma: gamma, theta: theta, vega: vega, rho: rho, theoretical: theoretical, intrinsicValue: intrinsicValue, daysBeforeExpiration: daysBeforeExpiration, stockSymbol: stockSymbol, contractSize: contractSize, payedAsk: askPrice)
    }
    
    var optionValuePL : Double {
        let contractSize = contractSize ?? 1
        return ((contractSize * (ask ?? 0)) - (contractSize * (payedAsk ?? 0))) * 100
//        return ((((contractSize ?? 1) * (ask ?? 0))) - (((contractSize ?? 1) * (payedAsk ?? 0))))
        
    }
    
    
    
}


