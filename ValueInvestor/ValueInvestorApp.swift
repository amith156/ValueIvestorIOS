//
//  ValueInvestorApp.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 22/06/2021.
//

import SwiftUI

@main
struct ValueInvestorApp: App {
    
    @StateObject private var stockHomeViewModel = StockHomeViewModel()
    @StateObject private var portfolioSettingsViewModel = PortfolioSettingsViewModel()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StockHomeView().navigationBarHidden(true)
            }
            .environmentObject(stockHomeViewModel)
            .environmentObject(portfolioSettingsViewModel)
            
            
        }
    }
}
