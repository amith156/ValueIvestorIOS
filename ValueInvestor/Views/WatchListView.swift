//
//  StockSearchList.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 28/06/2021.
//

import SwiftUI

struct WatchListView: View {
    
    @State private var searchText : String = ""
    @State private var searchTextFocuse : Bool = true
    
    
    
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
            
            SearchNavigation(text: $searchText, search: {}, cancel: {}) {
                
                List(0 ..< 30) { item in
                        
                    NavigationLink(

                        destination: Text("Destination"),
                        label: {

                            HStack {
                                VStack(alignment: .leading) {

                                    Text(searchText.isEmpty ? "Ticker Symbol" : "\(searchText)")
                                        .bold()


                                    Text("Company name")
                                        .font(.system(size: 18))
                                            .frame(alignment: .leading)

                                }
                                Spacer()
                                Text("$40.4")
                                    .font(.system(size: 23))
                            }
                            
                        }
                        
                    )
                        
                }
                .navigationTitle("WatchList")
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
