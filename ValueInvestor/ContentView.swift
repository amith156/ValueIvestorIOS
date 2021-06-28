//
//  ContentView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 22/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            HStack {
                Text("Watchlist")
                    .font(.system(size: 36, weight: .bold))
                Spacer()
            
                
                Button(action: {}, label: {
                    
                })
            
            }
            .padding()
            
            Spacer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
