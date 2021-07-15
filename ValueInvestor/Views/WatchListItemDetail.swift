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
        
        
        VStack {
            
            HStack {
                Text("\(resultObj.symbol)")
                Spacer()
            }
            
            
            
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
        WatchListItemDetail(resultObj: Result(symbol: "AAPL", bid: 140.5, ask: 180.5, shortName: "Apple Inc."))
    }
}
