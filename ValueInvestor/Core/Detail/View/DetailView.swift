//
//  DetailView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 19/08/2021.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var result: Result?
    
    var body: some View {
        
        ZStack {
            if let result = result {
                DetailView(result: result)
            }
            
            
        }
    }
}



struct DetailView: View {
    
    @StateObject var detailViewModel : DetailViewModel
    
    init(result : Result) {
        _detailViewModel = StateObject(wrappedValue: DetailViewModel(result: result))
        
        print("initializing detail screen for \(result.symbol)")
    }
    
    var body: some View {
        
        Text("hello")
            
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(result: dev.result)
    }
}
