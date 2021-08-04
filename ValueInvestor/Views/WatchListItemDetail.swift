//
//  WatchListItemDetail.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 15/07/2021.
//

import SwiftUI
import SwiftUICharts

struct WatchListItemDetail: View {
    
    @Environment(\.presentationMode) var presentationMode

    var resultObj : Result
    
    
    var body: some View {
        
        
        VStack(spacing: 8) {
            
            HStack {
                Text("\(resultObj.symbol)")
                    .font(.system(size: 32))
                    .bold()
                
                
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            
            Divider()
                .padding(.leading)
                .padding(.trailing)
            
            HStack(spacing: 12) {
                Text("\(resultObj.bid, specifier: "%.2f")")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.leading)
//                    .padding(.trailing)
                
                Divider()
                    .frame(height: 25)
                
                Text("\(resultObj.regularMarketChangePercent, specifier: "%.2f") %")
                    .font(.system(size: 21))
                    .foregroundColor(resultObj.regularMarketChangePercent.isLess(than: 0) ? Color(.red) : Color.primary)
                    .bold()
                
                Spacer()
                
            }
            
            Divider()
                .padding(.leading)
                .padding(.trailing)
            
            PriceGraph()
                .padding(.leading)
                .padding(.trailing)
            
            
            
            Divider()
                .padding(.leading)
                .padding(.trailing)

            
            HStack(spacing: 21){
                
                
                VStack(spacing: 6) {
                    FundamentalRatios(FundamentalName: "P/E Ratio", FundamentalValue: "7.4")
                    FundamentalRatios(FundamentalName: "P/S Ratio", FundamentalValue: "7.4")
                    FundamentalRatios(FundamentalName: "P/B Ratio", FundamentalValue: "7.4")

                }
                
                Divider()
                    .frame(height: 75)
                
                VStack(spacing: 6) {
                    FundamentalRatios(FundamentalName: "Debt-Equity", FundamentalValue: "7.4")
                    FundamentalRatios(FundamentalName: "P/E Ratio", FundamentalValue: "7.4")
                    FundamentalRatios(FundamentalName: "P/E Ratio", FundamentalValue: "7.4")

                }
                
//                Divider()
//                    .frame(height: 60)
//
//                VStack {
//                    FundamentalRatios(FundamentalName: "P/E Ratio", FundamentalValue: "7.4")
//                    FundamentalRatios(FundamentalName: "P/E Ratio", FundamentalValue: "7.4")
//                    FundamentalRatios(FundamentalName: "P/E Ratio", FundamentalValue: "7.4")
//
//                }
            }
            .padding()
            
            
            
            
            Spacer()
            

            
        }
        .navigationTitle("\(resultObj.shortName)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
                                    
            }, label: {
                Image(systemName: "chevron.backward")
            
        }))
    

    }
}

struct WatchListItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        WatchListItemDetail(resultObj: Result(symbol: "AAPL", bid: 140.5, ask: 180.5, shortName: "Apple Inc.", regularMarketChangePercent: -28.34))
    }
}

struct FundamentalRatios: View {
    
    var FundamentalName : String
    var FundamentalValue : String
    
    var body: some View {
        
        HStack(spacing: 8) {
            Text(FundamentalName)
                .font(.system(size: 17))
            
            
            Button(action: {
                
//                Rectangle()
//                    .frame(width: 40, height: 6, alignment: .center)
                
            }, label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
            })
            
            
                
            
            Spacer()
            
            Text(FundamentalValue)
                .font(.system(size: 17))
        }
        
    }
}
