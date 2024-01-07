//
//  NavBarView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 27/09/23.
//

import SwiftUI

struct NavBarView: View {
    
    @State private var isDrawerOpen = false
    private let width = UIScreen.main.bounds.width * 0.4
    
    var body: some View {
        VStack{
            HStack(spacing: 8){
                menuButton
                Spacer()
                SearchBarView()
            }
        }
        .padding()
        .foregroundStyle(Color.white)
        .background(Color("secondaryC").ignoresSafeArea(edges: .top))
    }
}

extension NavBarView {
    
    var menuButton: some View {
        Button(action: {
            isDrawerOpen.toggle()
        }, label: {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .frame(width: 18, height: 18)
        })
    }
    
    var drawerView: some View{
        HStack{
            Color.blue
                .ignoresSafeArea(.all)
                .frame(width: self.width)
                .offset(x: self.isDrawerOpen ? 0 : -self.width)
            Spacer()
        }
    }
}

struct SearchBarView: View {
    @State private var searchText = ""
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("secondaryC"))
            TextField("Search Your Card", text: $searchText)
                .foregroundStyle(Color(uiColor: .black))
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
    }
}

#Preview {
    NavBarView()
}
