//
//  Color.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 04/08/2021.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColourTheam()
    
}

struct ColourTheam {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
