//
//  Result.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 13/07/2021.
//

import Foundation

struct Result : Codable {
    
//    var id = UUID()
    let symbol: String
    let bid, ask: Double
    let shortName : String
    let regularMarketChangePercent : Double
    
}
