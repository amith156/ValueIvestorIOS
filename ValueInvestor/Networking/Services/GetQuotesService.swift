//
//  GetQuotesService.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 10/08/2021.
//

import Foundation
import Combine

class GetQuotesService {
    
    @Published var result : [Result] = []
    @Published var etfResult : [Result] = []
    @Published var getQuotes : GetQuotes = GetQuotes(quoteResponse: nil)
    var getQuoteCancellables : AnyCancellable?
    
    init() {
        downloadGetQuotes(tickerSymbols : "AMD,IBM,AAPL,GOOGL,FB,SNAP,AMZN,TSLA,PLTR,")
    }
    
    func getStockQuotes(tickerSymbols: String) {
        downloadGetQuotes(tickerSymbols: tickerSymbols)
    }
    
    private func downloadGetQuotes(tickerSymbols: String = "SPY,QQQ,GLD") {
        
//        https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=AAPL
        
        let queryitems = [URLQueryItem(name: "region", value: "US"),
                          URLQueryItem(name: "symbols", value: tickerSymbols+"SPY,QQQ,GLD,ILTB,VEU")]
        
        
        guard let url = URL(string: URLComponents().getQuotesURL!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            return
        }
        
        
        let requestURL = NSMutableURLRequest(url: url)
        requestURL.addValue("c9ebe735b0msh5f2608e4e3af023p1a8335jsn8a907a5b3270", forHTTPHeaderField: "x-rapidapi-key")
        
        NetworkManager.download(url: url)
            .decode(type: GetQuotes.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] receivedGetQuotes in
                self?.getQuotes = receivedGetQuotes
                guard let resultArray = receivedGetQuotes.quoteResponse?.result else {
                    return
                }
                
                let arr = receivedGetQuotes.quoteResponse!.result!.suffix(5)
                
                self?.etfResult = Array(arr)
                
                
                self?.result = resultArray
                print(resultArray[0].ask)
                self?.getQuoteCancellables?.cancel()
            })
    }
    
}

