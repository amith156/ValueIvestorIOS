//
//  WatchListItemDetail.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 15/07/2021.
//

import SwiftUI

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
