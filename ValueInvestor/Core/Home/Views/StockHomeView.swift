//
//  ContentView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 22/06/2021.
//

import SwiftUI

struct StockHomeView: View {
    
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioSettingsView : Bool = false // sheet view
    @EnvironmentObject private var stockHomeViewModel : StockHomeViewModel
    
    @State private var selctedStock : Result? = nil
    @State private var showDetailView : Bool = false
    
    
    var body: some View {
        
        ZStack {
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioSettingsView, content: {
                    PortfolioSettingView()
                        .environmentObject(stockHomeViewModel)
                })
            
            VStack {
                homeHeader
                
                ETFStatRow(showNextPageStat: $showPortfolio)
                
                SearchBarView(searchText: $stockHomeViewModel.searchText)
                    .autocapitalization(.allCharacters)
                    .disableAutocorrection(true)
                    .padding(.horizontal)

                columnHeadings
                    .padding(.horizontal)

                
                
                
                if(!showPortfolio) {
                    allStockList
                        .padding(.horizontal)
                        .transition(.move(edge: .leading))
                }
                if(showPortfolio) {
                    portfolioStockList
                        .padding(.horizontal)
                        .transition(.move(edge: .trailing))
                }
                
                
                Spacer(minLength: 0)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            
        }
        .background(
        
            NavigationLink(
                destination: DetailLoadingView(result: $selctedStock),
                isActive: $showDetailView,
                label: {
                    
                    EmptyView()
                })
        )
        
    }
}

struct StockHomeView_Previews: PreviewProvider {
    static var previews: some View {
        StockHomeView()
            .navigationBarHidden(true)
            .environmentObject(dev.stockHomeViewModel)
    }
}


extension StockHomeView {
    
    private var homeHeader : some View {
        HStack {
            CircleButtonView(iconeName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioSettingsView.toggle()
                    }
                }
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
    
    
    private var allStockList : some View {
        List {
            
            ForEach(stockHomeViewModel.arrayStocks, id: \.symbol) { stock in
                StockRowView(getResult: stock, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(result : stock)
                    }
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioStockList : some View {
        List {
            
            ForEach(stockHomeViewModel.portfolioStocks, id: \.symbol) { stock in
                StockRowView(getResult: stock, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(result : stock)
                    }
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
    
    private var columnHeadings : some View {
        HStack {
            Text("Ticker Symbol")
            Spacer()
            if(showPortfolio) {
                Text("Holdings")
            }
            Text("Price").frame(width: UIScreen.main.bounds.width/3, alignment: .trailing)
        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
    }
    
    
    private func segue(result: Result) {
        selctedStock = result
        showDetailView.toggle()
    }
    
    
    
}
