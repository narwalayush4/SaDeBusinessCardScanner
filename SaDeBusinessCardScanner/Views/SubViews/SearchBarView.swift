//
//  SearchBarView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 21/10/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("secondaryC"))
            TextField("Search Your Card", text: $searchText)
                .foregroundStyle(Color(uiColor: .black))
                .autocapitalization(.none)
                .disableAutocorrection(true)
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .opacity(searchText.isEmpty ? 0 : 1)
            }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray6))
        )
        .animation(.default, value: searchText)
    }
}
