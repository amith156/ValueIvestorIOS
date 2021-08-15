//
//  XMarkButtonView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 15/08/2021.
//

import SwiftUI

struct XMarkButtonView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        })
    }
}

struct XMarkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButtonView()
    }
}
