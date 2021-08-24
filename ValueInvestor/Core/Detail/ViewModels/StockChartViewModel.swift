//
//  StockChartViewModel.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 21/08/2021.
//

import Foundation
import Combine

class StockChartViewModel: ObservableObject {
    
    
    @Published var result : Result
    @Published var timeStamp : [Double] = []
    @Published var closingPrice : [Double] = []
    @Published var minY : Double = 0
    @Published var maxY : Double = 0
    @Published var median : Double = 0
    @Published var initialDate : String = ""
    @Published var initialTime : String = ""
    @Published var endDate : String = ""
    @Published var endTime : String = ""
    @Published var priceDirection : Double = 0
    
    
    private var getChartSetvice : GetChartService
    private var cancellable = Set<AnyCancellable>()
    
    init(result : Result) {
        
        self.result = result
        self.getChartSetvice = GetChartService(result: result)
        addSubscription()
    }
    
    func addSubscription() {
       
        getChartSetvice.$closingPrice
            .combineLatest(getChartSetvice.$timestamp)
            .map { (closingPrice, timeStamp) -> (closignPrice : [Double], timeStamp : [Double]) in
                
                let closingPriceArray = closingPrice.compactMap { element -> Double in
                    return element
                }
                
                let timeStampArray = timeStamp.compactMap { element -> Double in
                    return element
                }
        
                return (closingPriceArray, timeStampArray)
            }
            .sink { [weak self] returnedValue in
                self?.timeStamp = returnedValue.timeStamp
                self?.closingPrice = returnedValue.closignPrice
                self?.minY = returnedValue.closignPrice.min() ?? 0
                self?.maxY = returnedValue.closignPrice.max() ?? 0
                self?.median = ((returnedValue.closignPrice.min() ?? 0) + (returnedValue.closignPrice.max() ?? 0)) / 2
                self?.priceDirection = (returnedValue.closignPrice.last ?? 0) - (returnedValue.closignPrice.first ?? 0)
                
                let initial = self?.unixConversion(epocTime: returnedValue.timeStamp.first)
                self?.initialDate = initial?.dateStrign ?? ""
                self?.initialTime = initial?.timeString ?? ""
                
                let end = self?.unixConversion(epocTime: returnedValue.timeStamp.last)
                self?.endDate = end?.dateStrign ?? ""
                self?.endTime = end?.timeString ?? ""
                
            }
            .store(in: &cancellable)
        

        
    }
    
    
    func unixConversion(epocTime : Double?) -> (dateStrign: String, timeString : String) {
        
        guard let unixTime = epocTime else {
            return (dateStrign : "", timeString: "")
        }
        
        let date = Date(timeIntervalSince1970: unixTime)
        
        //date formating
        let formatDate = DateFormatter()
        formatDate.timeZone = TimeZone(abbreviation: "EST")
        formatDate.dateStyle = DateFormatter.Style.short
        formatDate.dateFormat = "dd-MM-yyyy"
        
        //time formating
        let formatTime = DateFormatter()
        formatTime.timeStyle = DateFormatter.Style.short
        formatTime.timeZone = TimeZone(abbreviation: "EST")
        
        return (dateStrign : formatDate.string(from: date), timeString: formatTime.string(from: date))
    }
    
    
    
}
