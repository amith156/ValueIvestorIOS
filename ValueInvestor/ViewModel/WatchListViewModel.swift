//
//  WatchListViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 09/07/2021.
//

import Foundation
import Combine

class WatchListViewModel : ObservableObject {
    
    @Published var resultObj: GetQuotes = GetQuotes()
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getResultObjects()
    }
    
    
    func getResultObjects() {
        
//        guard let url = URL(string: "") else {
//            return
//        }
        
        let headers = [
            "x-rapidapi-key" : "c9ebe735b0msh5f2608e4e3af023p1a8335jsn8a907a5b3270",
            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"
        ]
        
        
        var customURL : URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
            components.path = "/market/v2/get-quotes"
            components.queryItems = [
                URLQueryItem(name: "region", value: "US"),
                URLQueryItem(name: "symbols", value: "AMD%2CIBM%2CAAPL")
            ]
            
            return components.url
        }
        
        guard let url = customURL  else {
            return
        }
        
        let requestURL = NSMutableURLRequest(url: url)
        
        requestURL.httpMethod = "GET"
        requestURL.allHTTPHeaderFields = headers
        
//        URLSession.shared.dataTaskPublisher(for: <#T##URLRequest#>)
        
        
        
        
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
                
//                resultArrayObj.quoteResponse.result.forEach { item in
//                    self?.resultObj.append(item.itemQuotes)
//                }
                self?.resultObj = resultArrayObj
                print("#####> \(resultArrayObj)")
            })
            .store(in: &cancellables)
        
    }
    
    
    
}
