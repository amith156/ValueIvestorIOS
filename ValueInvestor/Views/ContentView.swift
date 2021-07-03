//
//  ContentView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 22/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        
        TabView {
            
            WatchList()
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Watchlist")
                }.tag(1)
            
            StockSearchList()
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Stock Search")
                }
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
