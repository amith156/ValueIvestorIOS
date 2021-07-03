//
//  WatchList.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 02/07/2021.
//

import SwiftUI

struct WatchList: View {
    
    @State var searchButtonToggle = false
    
    @State private var testsearchText : String = ""
    
    var body: some View {
        
        
        VStack {
            HStack {
                Text("Watchlist")
                    .font(.system(size: 36, weight: .bold))
                Spacer()
            
                
                Button(action: {
                    self.searchButtonToggle.toggle()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.original)
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0.0, y: 1)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0.0, y: 2)
                })
                .sheet(isPresented: self.$searchButtonToggle, content: {
                    StockSearchList()
                })
            
            }
            .padding()
            
            
            Spacer()
            
            
        }
        
        
        
        
    }
}

struct WatchList_Previews: PreviewProvider {
    static var previews: some View {
        WatchList()
    }
}
