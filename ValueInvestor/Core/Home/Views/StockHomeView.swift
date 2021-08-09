//
//  ContentView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 22/06/2021.
//

import SwiftUI

struct StockHomeView: View {
    
    @State private var showPortfolio : Bool = false
    
    var body: some View {
        
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
        
            VStack {
                homeHeader
                List {
                    StockRowView(getResult: DeveloperPreview.instance.result, showHoldingsColumn: false)
                }
                Spacer(minLength: 0)
            }
            
        }
        
        
    }
}

struct StockHomeView_Previews: PreviewProvider {
    static var previews: some View {
        StockHomeView()
            .navigationBarHidden(true)
    }
}


extension StockHomeView {
    
    private var homeHeader : some View {
        HStack {
            CircleButtonView(iconeName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            
            CircleButtonView(iconeName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }.padding(.horizontal)
    }
    
}
