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
    
    @Published var specficOptionData : GetOptionChain? = nil
    @Published var specficDatum : Datum? = nil
    @Published var specficAllCalls : [OptionData]? = nil
    @Published var specficAllPuts : [OptionData]? = nil
    
    @Published var portfolioOptionData : [OptionData] = []
    
    private var getOptionChainService : GetOptionChainService = GetOptionChainService()
    private var portfolioDataService : PortfolioDataService = PortfolioDataService()
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
        
        getOptionChainService.$newOptionDataForPortfolio
            .sink { [weak self] optionData in
                
                guard let data = optionData else {
                    return
                }
                
                self?.portfolioOptionData.append(data)
                print("option Count => \(self?.portfolioOptionData.count)")
            }
            
            .store(in: &cancellable)
        
        
        
        //adding new optionData when presed save
//        portfolioDataService.$optionsEntitySaved
//            .sink { [weak self] optionEntityArray in
//                optionEntityArray.forEach { optionsEntity in
//                    guard let ticker = optionsEntity.stockSymbol, let date = optionsEntity.expirationDate else {
//                        return
//                    }
//
////                    self?.getOptionSpecfic(tickerSymbole: ticker, date: date)
//                }
//            }
//            .store(in: &cancellable)
        
        
        
//        getOptionChainService.specficOptionChain
//            .map { optionChain in
//
//                let x = portfolioOptionData?.contains(where: { optionItem -> Bool in
//                    optionItem.optionSymbol == optionChain.code
//                })
//
//                guard let boolValue = x else {
//                    return
//                }
//
//
//
//
//            }
        
        
        
        
        
        
    }
    
    func updateOptions(askPrice : Double,
                       strickPrice : Double,
                       stockSymbol : String,
                       optionType : String,
                       expirationDate : String,
                       contractQuantity : Double) {
        
        portfolioDataService.addOptions(askPrice: askPrice,
                                        strickPrice: strickPrice,
                                        stockSymbol: stockSymbol,
                                        optionType: optionType,
                                        expirationDate: expirationDate,
                                        contractQuantity: contractQuantity)
    }
    
    func getOption(tickerSymbole : String) {
        getOptionChainService.getOptionData(tickerSymbol: tickerSymbole)
    }
    
    
    func getOptionSpecfic(tickerSymbole: String,
                          date : String,
                          askPrice: Double,
                          strick: Double,
                          optionType: String,
                          contractQuantity: Double) {
//        getOptionChainService.getOptionDataSpecfic(tickerSymbol: tickerSymbole, date: date)
        getOptionChainService.getOptionDataSpecfic(tickerSymbol: tickerSymbole,
                                                   date: date,
                                                   askPrice: askPrice,
                                                   strick: strick,
                                                   optionType: optionType,
                                                   contractQuantity: contractQuantity)
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
