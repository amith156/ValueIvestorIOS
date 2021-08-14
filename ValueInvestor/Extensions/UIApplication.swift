//
//  UIApplication.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 14/08/2021.
//

import SwiftUI
import Foundation

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
