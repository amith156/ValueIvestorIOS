//
//  CircleButtonView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 06/08/2021.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconeName : String
    
    var body: some View {
        Image(systemName: iconeName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconeName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconeName: "plus")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}
