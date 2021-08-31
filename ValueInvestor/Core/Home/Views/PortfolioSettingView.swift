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
    @State private var singleSharePrice : String = ""
    @State private var showSave: Bool = false
    
    @State private var selectionPicker : String = "Stocks"
    @State private var callPutSelection : String = "CALL"
    @State private var contractSize : Int = 1
    @State private var expirationDate : String = ""
    @State private var strickPrice : String = ""
    @State private var askPrice : String = ""
    
    
    @EnvironmentObject private var stockHomeViemModel : StockHomeViewModel
    @StateObject var portfolioSettingsViewModel : PortfolioSettingsViewModel = PortfolioSettingsViewModel()
    
//    init() {
//        _portfolioSettingsViewModel = StateObject(wrappedValue: PortfolioSettingsViewModel(tickerSymbol: "AAPL"))
//    }


    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
//                    Text("\(selectionPicker)")
                    SearchBarView(searchText: $stockHomeViemModel.searchText)
                        .autocapitalization(.allCharacters)
                        .disableAutocorrection(true)
                        .padding(.horizontal)
                    
                    stockSettingList
                    
                    if selectedStock != nil {
                        
                        Divider()
                            .padding(.bottom)
                        
                        Picker(selection: $selectionPicker,
                               label: Text("Picker"),
                               content: {
                                Text("Stocks").tag("Stocks")
                                Text("Options").tag("Options")
                               })
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom)
                            .padding(.horizontal)
                        
                        if selectionPicker == "Stocks" {
                            portfolioStockInputBlock
                            //                                .transition(.move(edge: .trailing))
                        }
                        else {

                            
                            portfolioOptionsInputBlock

                            //                            portfolioInputBlock
                            //                                .transition(.move(edge: .leading))
                        }
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
            .onChange(of: stockHomeViemModel.searchText, perform: { value in
                if(value == "") {
                    unSelectStock()
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
        if let quantity = Double(sharesQuantity), let buyingPrice = Double(singleSharePrice) {
            return quantity * (selectedStock?.regularMarketPrice ?? 0) - (quantity * buyingPrice)
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
                            portfolioSettingsViewModel.getOption(tickerSymbole: item.symbol)
                            resetOptionsData()
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
    
    private var portfolioStockInputBlock : some View {
        
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
                Text("Buying share price")
                Spacer()
                TextField("Ex $25", text: $singleSharePrice)
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
    
    
    private var portfolioOptionsInputBlock : some View {
        
        
        
        VStack(spacing: 21) {
            
            Group {
                HStack {
                    Text("Current Price of \(selectedStock?.symbol.uppercased() ?? "")")
                    Spacer()
                    Text(selectedStock?.regularMarketPrice.asCurrencyWith2Decimals() ?? "")
                }
            }
            
            Group {
                Divider()
                HStack {
                    Text("Option Type")
                    Spacer()
                    Picker(selection: $callPutSelection,
                           label:
                            
                            HStack {
                                Text(callPutSelection)
                            }.foregroundColor(.blue),
                           
                           content: {
                            Text("CALL").tag("CALL")
                            Text("PUT").tag("PUT")
                           })
                        .pickerStyle(MenuPickerStyle())
                }
            }
            
            Group {
                Divider()
                HStack {
                    Text("Contract Size : ")
                    Spacer()
                    
                    Stepper(value: $contractSize, in: 1...100, step: 1) {
                        Text("\(contractSize)")
                    }
                }
                
            }
            
            
            Group {
                Divider()
                HStack {
                    Text("Expiration Date")
                    
                    Spacer()
                    
                    Picker(selection: $expirationDate,
                           label: HStack() {
                            if expirationDate == "" {
                                Text("Date")
                            } else {
                                Text("\(expirationDate)")
                                
                            }
                            
                            
                           }.frame(alignment: .trailing)
                           .foregroundColor(.blue),
                           content: {
//                            pickedDate(expirationDate: expirationDate)

//                            self.portfolioSettingsViewModel.expirationDate.forEach { item in
//                                Text("\(item)").tag("\(item)")
//                            }
//                            portfolioSettingsViewModel.expirationDate
                            
                            ForEach(portfolioSettingsViewModel.expirationDate, id: \.self) { item in
                                Text("\(item)").tag("\(item)")
                            }
                            
                            
                           })
                        .pickerStyle(MenuPickerStyle())
                        .onReceive([self.expirationDate].publisher.first(), perform: { val in
                            print("the val -----> \(val)")
                            if let symbol = selectedStock?.symbol {
                                portfolioSettingsViewModel.getOptionSpecfic(tickerSymbole: symbol, date: val)
                            }
                            
                        })
                    
                }
            }
            
            
            Group {
                Divider()
                HStack {
                    Text("Strick Price")
                    Spacer()
                    
                    TextField("Ex $25", text: $strickPrice)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    
                }
            }
            
            Group{
                Divider()
                HStack {
                    Text("Ask Price")
                    
                    Spacer()
                    
                    TextField("19.55", text: $askPrice)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    
                }
            }
            
            Group {
                Divider()
                HStack {
                    Text("Current value")
                    Spacer()
                    Text(getCurrentValueStocks().asCurrencyWith2Decimals())
                }
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
                if selectionPicker == "Stocks" {
                    saveButtonPressedStock()
                } else {
                    savedButtonPressedOptions()
                }
                
            }, label: {
                Text("Save".uppercased())
                
            })
            .opacity(selectionPicker == "Stocks" ? (saveImageStockOpacity() ? 1.0 : 0.0) : (saveImageOptionsOpacity() ? 1.0 : 0.0) )
        }
        .font(.headline)
    }
    
    func saveImageStockOpacity() -> Bool {
        return (selectedStock != nil && selectionPicker == "Stocks" && (selectedStock?.currentStockHoldings != Double(sharesQuantity)) && singleSharePrice != "")
    }
    
    func saveImageOptionsOpacity() -> Bool {
        return (selectedStock != nil && selectionPicker == "Options" && expirationDate != "" && strickPrice != "" && askPrice != "")
    }
    
    func savedButtonPressedOptions() {
        
        guard let aksPriceNew =  Double(askPrice),
              let strickPriceNew = Double(strickPrice),
              let stockSymbolNew = selectedStock?.symbol else {
            return
        }
        
        portfolioSettingsViewModel.updateOptions(askPrice: aksPriceNew, strickPrice: strickPriceNew, stockSymbol: stockSymbolNew, optionType: callPutSelection, expirationDate: expirationDate, contractSize: Double(contractSize))
        
        
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
    
//    let strickPrice = Double(strickPrice),
//    let stockSymbol = selectedStock?.symbol,
//    let optionType = cllPutSelection,
//    let expirationDate = expirationDate,
//    let contractSize = Double(contractSize)
    
    private func saveButtonPressedStock() {
        
        
        guard  let stock = selectedStock, let amount = Double(sharesQuantity), let buyingPrice = Double(singleSharePrice) else {
            return
        }
        
        //        save to Portfolio
        stockHomeViemModel.updatePortfolio(stock: stock, amount: amount, buyingPrice: buyingPrice)
        
        
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
    
    
    func resetOptionsData() {
        callPutSelection = "CALL"
        contractSize = 1
        expirationDate = ""
        strickPrice = ""
        askPrice = ""

    }
}
