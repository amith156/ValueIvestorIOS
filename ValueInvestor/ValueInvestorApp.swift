//
//  ValueInvestorApp.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 22/06/2021.
//

import SwiftUI

@main
struct ValueInvestorApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StockHomeView()
            }
            .navigationBarHidden(true)
            
        }
    }
}
