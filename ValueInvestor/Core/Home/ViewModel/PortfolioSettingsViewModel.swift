//
//  PortfolioSettingsViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 30/08/2021.
//

import Foundation
import Combine

class PortfolioSettingsViewModel : ObservableObject {
    
    @Published var expirationDate : [String] = []
    @Published var strickPrice : [Double] = []
    
    @Published var specficDatum : Datum? = nil
    @Published var specficAllCalls : [OptionData]? = nil
    @Published var specficAllPuts : [OptionData]? = nil
    
    private var getOptionChainService : GetOptionChainService = GetOptionChainService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers () {
        
        getOptionChainService.$allExpirationDate
            .sink { [weak self] exper in
                self?.expirationDate = exper
            }
            .store(in: &cancellable)
        
        
        
    }
    
    
    
    func getOption(tickerSymbole : String) {
        getOptionChainService.getOptionData(tickerSymbol: tickerSymbole)
    }
    
    
    func getOptionSpecfic(tickerSymbole: String, date : String) {
        getOptionChainService.getOptionDataSpecfic(tickerSymbol: tickerSymbole, date: date)
    }
    
    
    func getSelectedDate(date : String) {
        
        
//        getOptionChainService.
        
        
        
        
//        getOptionChainService.$optionData
//            .map({ getOptionChain -> Datum? in
//
//                guard let getOptionData = getOptionChain else {
//                    return nil
//                }
//
//                let selectedDatum = getOptionData.data.map({ datumArray -> Datum? in
//
//                    let selectedOBj = datumArray.first { datum -> Bool in
//                        return datum.expirationDate! == date
//                    }
//
//
//                    guard let selectedDate = selectedOBj else {
//                        return nil
//                    }
//
//                    return selectedDate
//
//                })
//
//                guard let datum = selectedDatum else {
//                    return nil
//                }
//
//                return datum ?? nil
//
//
//            })
//            .sink { [weak self] recivedDatum in
//
//                print("\(recivedDatum?.expirationDate)")
//                guard let datum = recivedDatum else {
//                    return
//                }
//                var tempStrickPrice : [Double] = []
//
//
//
//                if let options = datum.options {
//                    if let call = options.call {
//                        call.forEach { optionData in
//                            if let strick = optionData.strike {
//                                tempStrickPrice.append(strick)
//                            }
//                        }
//                    }
//                }
//
//
//
//
//                print("size = \(tempStrickPrice.count)")
//
//                self?.strickPrice = tempStrickPrice
//
//
//            }
//            .store(in: &cancellable)
        
        
    }
    
    
}
