//
//  NetworkManager.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 11/08/2021.
//

import Foundation
import Combine

class NetworkManager {
    
    enum NetworkingError : LocalizedError {
        case badURLRequest(url: URL)
        case unknown
        
        var errorDiscription : String {
            switch self {
            case .badURLRequest(url: let url):
                return "=====> [⛔️] Bad responce from URL: \(url)"
            case .unknown:
                return "=====> [⚠️] Unknown error"
            }
        }
        
        
    }
    
    
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        
        let headers = [
            "x-rapidapi-key" : ApiKey.YahooFinanceKey,
            "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"
        ]

        
        let requestURL = NSMutableURLRequest(url: url)
//        requestURL.addValue("5d24937f4bmsh8dfb5d85065f33fp15a001jsnd6bc562839e9", forHTTPHeaderField: "x-rapidapi-key")
        requestURL.httpMethod = "GET"
        requestURL.allHTTPHeaderFields = headers
        
        
        
        return URLSession.shared.dataTaskPublisher(for: requestURL as URLRequest)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ data in
                try handleURLResponce(output: data, url: url)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        
    }
    
    static func handleURLResponce(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let responce = output.response as? HTTPURLResponse else {
            throw NetworkingError.badURLRequest(url: url)
        }
        print(responce.statusCode)
        return output.data
        
        
    }
    
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("===> \(error.localizedDescription)")
        }
    }
    
    
}

