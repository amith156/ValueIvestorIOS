//
//  GetChartService.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 21/08/2021.
//

import Foundation
import Combine

class GetChartService {
    
    @Published var timestamp : [Double] = []
    @Published var closingPrice : [Double] = []
    @Published var getChart : GetChart = GetChart(chart: nil)
    
    var result : Result
    
    var cancellable : AnyCancellable?
    
    
    //interval => 1m|2m|5m|15m|60m|1d
    //range => 1d|5d|1mo|3mo|6mo|1y|2y|5y|10y|ytd|max
    init(result : Result) {
        self.result = result
        getChartData(symbol: result.symbol, interval: "1d", range: "1y")
        
    }
    
    
    func getChartData(symbol : String, interval : String, range : String) {
        
        let queryitems = [URLQueryItem(name: "region", value: "US"),
                          URLQueryItem(name: "symbol", value: symbol),
                          URLQueryItem(name: "interval", value: interval),
                          URLQueryItem(name: "range", value: range)]
        
        guard let url = URL(string: URLComponents().getChartURL!.absoluteString)?
                .appendQueryItems(queryItems: queryitems) else {
            return
        }

        cancellable = NetworkManager.download(url: url)
            .decode(type: GetChart.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                NetworkManager.handleCompletion(completion: completion)
            }, receiveValue: { [weak self] receivedGetChart in
                self?.getChart = receivedGetChart
                self?.closingPrice = receivedGetChart.chart?.result?[0].indicators?.quote?[0].close ?? []
                self?.timestamp = receivedGetChart.chart?.result?[0].timestamp ?? []
                
                self?.cancellable?.cancel()
            })
        

    }
    
}
