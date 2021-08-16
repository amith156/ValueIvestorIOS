//
//  PortfolioSettingView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 15/08/2021.
//

import SwiftUI

struct PortfolioSettingView: View {
    
    @State private var selectedStock : Result? = nil
    @State private var sharesQuantity: String = ""
    @State private var showSave: Bool = false
    @EnvironmentObject private var stockHomeViemModel : StockHomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    SearchBarView(searchText: $stockHomeViemModel.searchText)
                    
                    stockSettingList
                    
                    if selectedStock != nil {
                        
                        Divider()
                            .padding(.bottom)
                        portfolioInputBlock
                        
                    }
                    
                    
                }
            }
            .navigationTitle("Add Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButtonView()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    navigationTrailingBarButton
                    
                }
                
            })
            
        }
    }
}

struct PortfolioSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSettingView()
            .environmentObject(dev.stockHomeViewModel)
    }
}


extension PortfolioSettingView {
    
    private func getCurrentValueStocks() -> Double {
        if let quantity = Double(sharesQuantity) {
            return quantity * (selectedStock?.regularMarketPrice ?? 0)
        } else {
            return 0
        }
    }
    
    
    
    private var stockSettingList : some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(stockHomeViemModel.arrayStocks, id: \.symbol) { item in
                    PortfolioSettingStockView(getResult: item)
                        .frame(width: 80)
                        .padding(5)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedStock = item
                            }
                        }
                        
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedStock?.symbol == item.symbol ? Color.theme.green : Color.clear, lineWidth: 1)
                            
                        )
                }
            }
            .frame(height: 100)
            
            .padding(.leading)
            
        })
        
    }
    
    private var portfolioInputBlock : some View {
        
        VStack(spacing: 21) {
            
            HStack {
                Text("Current Price of \(selectedStock?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedStock?.regularMarketPrice.asCurrencyWith2Decimals() ?? "")
            }
            
            Divider()
            HStack {
                Text("Shares holding")
                Spacer()
                TextField("Ex 300", text: $sharesQuantity)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            
            Divider()
            HStack {
                Text("Current value")
                Spacer()
                Text(getCurrentValueStocks().asCurrencyWith2Decimals())
            }
            
        }
        .font(.headline)
        .animation(.none)
        .padding(.horizontal)
        
        
        
    }
    
    
    private var navigationTrailingBarButton : some View {
        
        
        HStack(spacing: 10) {
            Image(systemName: "externaldrive.fill.badge.checkmark")
                .opacity(showSave ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
                    
            })
            .opacity((selectedStock != nil && selectedStock?.currentStockHoldings != Double(sharesQuantity)) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    
    
    private func saveButtonPressed() {
        
        
        guard  let stock = selectedStock else {
            return
        }
        
//        save to Portfolio
        
//        show Save Icon
        withAnimation(.easeIn) {
            showSave = true
            unSelectStock()
        }
        
        
//        hide save icon
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            withAnimation(.easeOut) {
                showSave = false
            }
        }
        
        
//        dismis Keyboard
        UIApplication.shared.endEditing()
        
        
        
        
    }
    
    
    private func unSelectStock() {
        stockHomeViemModel.searchText = ""
        selectedStock = nil
        
    }
    
    
}
