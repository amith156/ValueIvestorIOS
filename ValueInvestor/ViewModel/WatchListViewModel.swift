//
//  WatchListViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 09/07/2021.
//

import Foundation
import Combine

class WatchListViewModel : ObservableObject {
    
    @Published var resultObj = [Result]()
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
//        getResultObjects()
        
        resultObj.append(Result(symbol: "AAPL", bid: 140.5, ask: 180.5, shortName: "Apple Inc.", regularMarketChangePercent: -2.45))
        resultObj.append(Result(symbol: "ZM", bid: 352.67, ask: 180.5, shortName: "Zoom Inc.", regularMarketChangePercent: 1.24))
        resultObj.append(Result(symbol: "IBM", bid: 56.54, ask: 180.5, shortName: "International Business Machines", regularMarketChangePercent: -3.44))
        resultObj.append(Result(symbol: "PSTH", bid: 20.84, ask: 180.5, shortName: "Pershing Square Capital", regularMarketChangePercent: 5.12))
        resultObj.append(Result(symbol: "TSLA", bid: 668.94, ask: 180.5, shortName: "Tesla Inc.", regularMarketChangePercent: -6.17))
        resultObj.append(Result(symbol: "KL", bid: 42.8, ask: 180.5, shortName: "Kerkland Lake Gold Inc.", regularMarketChangePercent: -0.38))
    }
    
    
    func getResultObjects() {
        
        
        let headers = [
            "x-rapidapi-key" : "c9ebe735b0msh5f2608e4e3af023p1a8335jsn8a907a5b3270",
//            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"
        ]
        
        
        var customURL : URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
            components.path = "/market/v2/get-quotes"
            components.queryItems = [
                URLQueryItem(name: "region", value: "US"),
                URLQueryItem(name: "symbols", value: "AMD%2CIBM%2CAAPL%2CTSLA%2CZM")
            ]
            
            return components.url
        }
        
        guard let url = customURL  else {
            return
        }
        
        let requestURL = NSMutableURLRequest(url: url)
        
        requestURL.httpMethod = "GET"
        requestURL.allHTTPHeaderFields = headers
        
        
        URLSession.shared.dataTaskPublisher(for: requestURL as URLRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, responce) -> Data in

                guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                    throw URLError(.badURL)
                }

                print("-----> (\(data.count)")
                return data
            }
            .decode(type: GetQuotes.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
//                completion in
//                print("-----> COMPLETION: \(completion)")
                print("=====> \($0)")
            }, receiveValue: { [weak self] resultArrayObj in
                
                resultArrayObj.quoteResponse?.result.forEach({ obj in
                    self?.resultObj.append(obj)
                })
                
                
                print("#####> \(resultArrayObj)")
            })
            .store(in: &cancellables)
        
    }
    
    
    
}
