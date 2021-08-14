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
        
        let requestURL = NSMutableURLRequest(url: url)
        requestURL.addValue("c9ebe735b0msh5f2608e4e3af023p1a8335jsn8a907a5b3270", forHTTPHeaderField: "x-rapidapi-key")
        
        return URLSession.shared.dataTaskPublisher(for: requestURL as URLRequest)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ data in
                try handleURLResponce(output: data, url: url)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        
    }
    
    static func handleURLResponce(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let responce = output.response as? HTTPURLResponse, responce.statusCode >= 200 && responce.statusCode < 300 else {
            throw NetworkingError.badURLRequest(url: url)
        }
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

