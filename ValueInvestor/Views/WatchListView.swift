//
//  WatchListView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 28/06/2021.
//

import SwiftUI

struct WatchListView: View {
    
    @State private var searchText : String = ""
    @State private var searchTextFocuse : Bool = true
    @StateObject var watchListViewModel = WatchListViewModel()
    var resultArray : [Int] = [1,2,3,4,5]
    
    
    
    init() {
        
        //Setting the styling and font for the tiltle
        let design = UIFontDescriptor.SystemDesign.default
        var descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
                                         .withDesign(design)!
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.bold]])
        let font = UIFont.init(descriptor: descriptor, size: 40)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
    }
    
    
    
    
    
    var body: some View {

        VStack {
//            guard let x = watchListViewModel.resultObj else {
//                Text("****")
//            }
            
            SearchNavigation(text: $searchText, search: {}, cancel: {}) {


                List(watchListViewModel.resultObj, id: \.symbol ) { item in
//                List(1 ..< 20 ) { item in
                    NavigationLink(

                        destination:
                            WatchListItemDetail(resultObj: item)
                            
                            
//                            Text("Destination")
                        
                        
                        ,
                        label: {

                            HStack {
                                VStack(alignment: .leading) {

//                                    Text(searchText.isEmpty ? "Ticker Symbol" : "\(searchText)")
//                                        .bold()

                                    Text(item.symbol)
                                        .font(.system(size: 18))
                                        .bold()
                                    
                                    
//                                    Text("Company Name")
//                                        .font(.system(size: 14))
//                                        .frame(alignment: .leading)
                                    
                                    
                                    Text(item.shortName)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.gray)
                                        .frame(alignment: .leading)
                                    


                                }
                                Spacer()
                                
//                                Text("$44.20")
//                                    .font(.system(size: 23))
                                
                                Text("\(item.bid, specifier: "$%.2f" )")
                                    .font(.system(size: 23))
                                
                            }

                        }

                    )

                }
                .navigationTitle("Watchlist")
                .listStyle(InsetGroupedListStyle())
            }

            
        }
        .ignoresSafeArea()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif



struct StockSearchList_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
