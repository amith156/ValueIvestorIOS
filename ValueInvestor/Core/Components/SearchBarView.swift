//
//  SearchBarView.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 14/08/2021.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search Ticker Symbol", text: $searchText)
                .textCase(searchText.isEmpty ? .lowercase : .uppercase)
                .foregroundColor(Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .foregroundColor(Color.theme.accent)
                        .offset(x: 10.0, y: 0)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    
                    ,alignment: .trailing
                
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 26.0)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.17), radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.light).previewLayout(.sizeThatFits)
            
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark).previewLayout(.sizeThatFits)
        }
    }
}
