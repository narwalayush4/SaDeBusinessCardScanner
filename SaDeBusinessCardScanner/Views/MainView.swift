//
//  ContentView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI
import SwiftData
import Inject

struct MainView: View {
    
    @ObserveInjection var inject
    
    @Query(sort: \Card.timeStamp) private var cards: [Card]
    
    @State private var searchText = ""
    @State private var isDrawerOpen = false
    @State var isLoading = true
    
    private var filteredCards: [Card] {
        if searchText.isEmpty {
            return cards
        }
        
        return cards.filter { card in
            let searchString = searchText.lowercased()
            return card.name.lowercased().contains(searchString) ||
                   card.company.lowercased().contains(searchString) ||
                   card.address.lowercased().contains(searchString)
        }
    }
    
    var body: some View {
        NavigationStack {
            if isLoading{
                LoadingVIew()
                    .onAppear(perform: { isLoading = false })
            } else {
                ZStack{
                    VStack{
                        NavBarView(isDrawerOpen: $isDrawerOpen, searchText: $searchText)
                        Spacer()
                        VStack{
                            if cards.isEmpty{
                                Image("image1")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                Text("Create your first Card Scan")
                                    .foregroundStyle(Color("secondaryC"))
                                    .fontWeight(.medium)
                            } else {
                                ScrollView {
                                    VStack(spacing: 20.0) {
                                        ForEach(filteredCards) { card in
                                            CardView(card: card)
                                        }
                                    }
                                    .foregroundStyle(Color.black)
                                }
                            }
                        }
                        Spacer()
                        TabBarView()
                    }
                    .background(Color.primaryC)
                    .opacity(isDrawerOpen ? 0.7 : 1.0)
                    .allowsHitTesting(!isDrawerOpen)
                    if isDrawerOpen{
                        HStack(spacing: 0){
                            DrawerView(isDrawerOpen: $isDrawerOpen)
                            Rectangle()
                                .ignoresSafeArea()
                                .foregroundStyle(Color.black)
                                .opacity(0.3)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation {
                                        self.isDrawerOpen.toggle()
                                    }
                                }
                        }
                    }
                }
            }
        }
        .enableInjection()
    }
}


#Preview {
    MainView()
}
