//
//  ETFModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 14/08/2021.
//

import Foundation

struct ETFModel : Identifiable {
    
    let id = UUID().uuidString
    let title : String
    let value: String
    let percentChange : Double?
    
    init(title: String, value: String, percentChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentChange = percentChange
    }
}
