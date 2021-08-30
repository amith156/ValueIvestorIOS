//
//  URL.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 10/08/2021.
//

import Foundation

extension URLComponents {
    
    var getQuotesURL : URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
        components.path = "/market/v2/get-quotes"

        
        return components.url
        
    }
    
    
    var getProfileURL : URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
        components.path = "/stock/v2/get-profile"
        
        return components.url
        
    }
    
    
    var getChartURL : URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
        components.path = "/stock/v2/get-chart"
        
        return components.url
        
    }
    
    
    
    var getOptionChainURL : URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "eodhistoricaldata.com"
        components.path = "/api/options/"
        
        return components.url
        
    }
    
    
    func getOptionURL(symbole : String) -> URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "eodhistoricaldata.com"
        components.path = "/api/options/\(symbole)"
        
        return components.url
    }

    
    
    
}
