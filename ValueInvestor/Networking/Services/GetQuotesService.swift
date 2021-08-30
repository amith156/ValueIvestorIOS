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
    @Published var portfolioDB : [Result] = []
    @Published var searchResultArray : [Result] = []
    @Published var etfResult : [Result] = []
    @Published var getQuotes : GetQuotes = GetQuotes(quoteResponse: nil)
    
    var watchList : String = "AMD,IBM,AAPL,GOOGL,FB,SNAP,AMZN,TSLA,PLTR,SPY,QQQ,GLD,ILTB,VEU"
    
    var getQuoteCancellables : AnyCancellable?
    
    init() {
        downloadGetQuotesInitial(tickerSymbols: watchList)
    }
    
    func getStockQuotes(tickerSymbols: String?) {
       if tickerSymbols != nil {
            downloadGetQuotesInitial(tickerSymbols: tickerSymbols!)
        } else if tickerSymbols == nil {
            downloadGetQuotesInitial(tickerSymbols: watchList)
        }
    }
    
    func getStockQuotesSearch(tickerSymbol : String) {
        downloadGetQuotesSearch(tickerSymbols: tickerSymbol)
    }
    
    private func downloadGetQuotesSearch(tickerSymbols: String ) {
        
        let queryitems = [URLQueryItem(name: "region", value: "US"),
                          URLQueryItem(name: "symbols", value: tickerSymbols)]
        
        
        guard let url = URL(string: URLComponents().getQuotesURL!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            return
        }
        
        
        let requestURL = NSMutableURLRequest(url: url)
        requestURL.addValue(ApiKey.YahooFinanceKey, forHTTPHeaderField: "x-rapidapi-key")
        
        getQuoteCancellables = NetworkManager.downloadYahoo(url: url)
            .decode(type: GetQuotes.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] receivedGetQuotes in
                self?.getQuotes = receivedGetQuotes
                guard let resultArray = receivedGetQuotes.quoteResponse?.result else {
                    return
                }
                self?.result.append(resultArray[0])
                self?.searchResultArray = resultArray
                self?.getQuoteCancellables?.cancel()
            })
    }
    
    public func downloadGetQuotesDB(tickerSymbols: String ) {
        
        let queryitems = [URLQueryItem(name: "region", value: "US"),
                          URLQueryItem(name: "symbols", value: tickerSymbols)]
        
        
        guard let url = URL(string: URLComponents().getQuotesURL!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            return
        }
        
        
        let requestURL = NSMutableURLRequest(url: url)
        requestURL.addValue(ApiKey.YahooFinanceKey, forHTTPHeaderField: "x-rapidapi-key")
        
        NetworkManager.downloadYahoo(url: url)
            .decode(type: GetQuotes.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] receivedGetQuotes in
                self?.getQuotes = receivedGetQuotes
                guard let resultArray = receivedGetQuotes.quoteResponse?.result else {
                    return
                }
//                self?.result.append(resultArray[0])
                self?.portfolioDB.append(resultArray[0])
                print("port count -> \(self?.portfolioDB.count)")
                self?.getQuoteCancellables?.cancel()
            })
    }
    
    
    private func downloadGetQuotesInitial(tickerSymbols: String) {
        
//        https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=AAPL
        
        let queryitems = [URLQueryItem(name: "region", value: "US"),
                          URLQueryItem(name: "symbols", value: tickerSymbols)]
        
        
        guard let url = URL(string: URLComponents().getQuotesURL!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            return
        }
        
        
        let requestURL = NSMutableURLRequest(url: url)
        requestURL.addValue(ApiKey.YahooFinanceKey, forHTTPHeaderField: "x-rapidapi-key")
        
        NetworkManager.downloadYahoo(url: url)
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
                self?.getQuoteCancellables?.cancel()
            })
    }
    
}

