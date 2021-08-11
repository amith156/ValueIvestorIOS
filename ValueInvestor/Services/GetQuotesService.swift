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
    @Published var getQuotes : GetQuotes = GetQuotes(quoteResponse: nil)
    var getQuoteCancellables : AnyCancellable?
    
    init() {
        downloadGetQuotes()
    }
    
    private func downloadGetQuotes() {
        
//        https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=AAPL
        
        let queryitems = [URLQueryItem(name: "region", value: "US"),
                          URLQueryItem(name: "symbols", value: "AMD,IBM,AAPL")]
        
        
        guard let url = URL(string: URLComponents().getQuotesURL!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            return
        }
        
        
        let requestURL = NSMutableURLRequest(url: url)
        requestURL.addValue("c9ebe735b0msh5f2608e4e3af023p1a8335jsn8a907a5b3270", forHTTPHeaderField: "x-rapidapi-key")
        
        URLSession.shared.dataTaskPublisher(for: requestURL as URLRequest)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                
                guard let responce = output.response as? HTTPURLResponse, responce.statusCode >= 200 && responce.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: GetQuotes.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("===> \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] receivedGetQuotes in
                self?.getQuotes = receivedGetQuotes
                guard let resultArray = receivedGetQuotes.quoteResponse?.result else {
                    return
                }
                
                self?.result = resultArray
                print(resultArray[0].ask)
                self?.getQuoteCancellables?.cancel()
            }
            
            
        
        
        
    }
    
}

