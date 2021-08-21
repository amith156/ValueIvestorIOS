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
    private let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing : CGFloat = 30
    
    init(result : Result) {
        _detailViewModel = StateObject(wrappedValue: DetailViewModel(result: result))
        
        print("initializing detail screen for \(result.symbol)")
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                Text((detailViewModel.result.shortName ?? detailViewModel.result.longName) ?? detailViewModel.result.symbol)
                    .frame(height: 150)
                
                overviewTitle
                Divider()

                overviewGrid
                
                
                ratiosTitle
                
                Divider()
                
                ratiosGrid
                
            }
            .padding()
        }
        .navigationTitle(detailViewModel.result.symbol)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(result: dev.result)
        }
    }
}


extension DetailView {
    
    private var overviewTitle: some View {
        
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
       
    }

    private var overviewGrid : some View {
        
        LazyVGrid(columns: column,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
                    ForEach(detailViewModel.overViewStats) { stats in
                        StatsView(stat: stats)
                    }
                  })
    }

    
    private var ratiosTitle: some View {
        
        Text("Ratios")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    
    private var ratiosGrid: some View {
        LazyVGrid(columns: column,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
                    ForEach(detailViewModel.ratioStats) { stats in
                        StatsView(stat: stats)
                    }
                  })
    
    }
}
