//
//  StockDetailDataService.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 20/08/2021.
//

import Foundation
import Combine

class StockDetailDataService {
    
    @Published var profile : GetProfile? = nil
    @Published var businessSummary : String = ""
    let result: Result
    var detailSubscription : AnyCancellable?
    
    
    init(result : Result) {
        self.result = result
        downloadGetProfile()
    }
    
    
    private func downloadGetProfile() {
        
        //        https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-summary?region=US&symbol=AMRN
        
        let headers = [
            "x-rapidapi-key" : "5d24937f4bmsh8dfb5d85065f33fp15a001jsnd6bc562839e9",
            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"
        ]
        
        
        let queryitems = [
            URLQueryItem(name: "symbol", value: result.symbol),
            URLQueryItem(name: "region", value: "US")]
        
        
        guard let url = URL(string: URLComponents().getProfileURL!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            return
        }
        
//        let request = NSMutableURLRequest(url: NSURL(string: "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-profile?symbol=AMRN&region=US")! as URL)
        
        let requestURL = NSMutableURLRequest(url: url)
        
        requestURL.httpMethod = "GET"
        requestURL.allHTTPHeaderFields = headers
        requestURL.cachePolicy = .useProtocolCachePolicy
        requestURL.timeoutInterval = 10.0
        
        detailSubscription = NetworkManager.download(url: url)
            .decode(type: GetProfile.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] receivedGetSummary in
                print("-------->\(receivedGetSummary)")

                self?.profile = receivedGetSummary
                self?.businessSummary = receivedGetSummary.assetProfile?.longBusinessSummary ?? ""
                self?.detailSubscription?.cancel()
            })
    }
}
