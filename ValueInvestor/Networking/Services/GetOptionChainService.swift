//
//  GetOptionChainService.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 28/08/2021.
//

import Foundation
import Combine

class GetOptionChainService {
    
    @Published var optionData : GetOptionChain? = nil
    @Published var allExpirationDate : [String] = []
    
    @Published var specficOptionChain : GetOptionChain? = nil
    @Published var specficDatum : Datum? = nil
    @Published var specficAllCalls : [OptionData]? = nil
    @Published var specficAllPuts : [OptionData]? = nil
    @Published var newOptionDataForPortfolio : OptionData? = nil
    
    var optionChainSubscription : AnyCancellable?
    
//    init(tickerSymbol : String) {
//        getOptionData(tickerSymbol: tickerSymbol)
//    }
    
//    date: String = "2021-12-17"
    
    
    func getOptionData(tickerSymbol: String) {
        
        let queryitems = [
            URLQueryItem(name: "api_token", value: ApiKey.EODOptionsKey),
//            URLQueryItem(name: "to", value: date),
//            URLQueryItem(name: "from", value: date)
        ]

        guard let url = URL(string: URLComponents().getOptionURL(symbole: tickerSymbol)!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            print("!!!!!!-> URL Error")
            return
        }
        
        optionChainSubscription = NetworkManager.downloadOptions(url: url)
            .decode(type: GetOptionChain.self, decoder: JSONDecoder())
            .sink { completion in
                NetworkManager.handleCompletion(completion: completion)
            } receiveValue: { [weak self] recivedOptionChain in
                
                self?.optionData = recivedOptionChain
//                print("option data -----> \(recivedOptionChain)")
                
                var tempExperation : [String] = []
                recivedOptionChain.data?.forEach({ datum in
                    if let expDate = datum.expirationDate {
                        tempExperation.append(expDate)
                    }
                    self?.allExpirationDate = tempExperation
                })

                
                self?.optionChainSubscription?.cancel()
            }
        
    }
    
    
    
    func getOptionDataSpecfic(tickerSymbol: String, date: String, askPrice : Double, strick : Double, optionType: String, contractQuantity : Double) {
        
        let queryitems = [
            URLQueryItem(name: "api_token", value: ApiKey.EODOptionsKey),
            URLQueryItem(name: "to", value: date),
            URLQueryItem(name: "from", value: date)
        ]

        guard let url = URL(string: URLComponents().getOptionURL(symbole: tickerSymbol)!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            print("!!!!!!-> URL Error")
            return
        }
        
        optionChainSubscription = NetworkManager.downloadOptions(url: url)
            .decode(type: GetOptionChain.self, decoder: JSONDecoder())
            .sink { completion in
                NetworkManager.handleCompletion(completion: completion)
            } receiveValue: { [weak self] recivedOptionChain in
                
                self?.specficOptionChain = recivedOptionChain
                self?.specficDatum = recivedOptionChain.data?.first
                self?.specficAllCalls = recivedOptionChain.data?.first?.options?.call
                self?.specficAllPuts = recivedOptionChain.data?.first?.options?.put
                
                var optionData : OptionData? = nil
                
                if optionType == "CALL" {
                    optionData = recivedOptionChain.data?.first?.options?.call?.first(where: { optionItem in
                        optionItem.strike == strick
                    })
                } else if optionType == "PUT" {
                    optionData = recivedOptionChain.data?.first?.options?.put?.first(where: { optionItem in
                        optionItem.strike == strick
                    })
                }
                print("yyyyyy----> \(optionData)")
                guard let x = optionData else {
                    return
                }
                
                let newData = x.updateOptionData(askPrice: askPrice,
                                   strickPrice: strick,
                                   stockSymbol: tickerSymbol,
                                   optionType: optionType,
                                   expirationDate: date,
                                   contractQuantity: contractQuantity)
                print("xxxxxx----> \(newData)")
                self?.newOptionDataForPortfolio = newData
                self?.optionChainSubscription?.cancel()
            }
        
        
        
    }
    
    
}
