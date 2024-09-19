//
//  ContentView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Card.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "timeStamp_", ascending: true)])
    var cards: FetchedResults<Card>
    
    
    @State private var searchText = ""
    @State private var isDrawerOpen = false
    @State var isLoading = true
    private let width = UIScreen.main.bounds.width * 0.55
    
    var body: some View {
        NavigationStack {
            if isLoading{
                LoadingVIew()
                    .onAppear(perform: {
                        // Simulate loading delay (you can replace this with your actual loading logic)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isLoading = false
                            }
                        }
                    })
            } else {
                ZStack{
                    VStack{
                        NavBarView
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
                                        ForEach(cards){ card in
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
                            DrawerView
                                .background(.white)
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
        
    }
}

extension MainView{
    
    var DrawerView: some View{
        VStack(alignment: .leading, spacing: 20){
            Image("logo_512x512")
                .resizable()
                .scaledToFit()
                .frame(width: width)
                .padding(.vertical)
            Group{
                NavigationLink(destination: GroupsView(), label: {
                    HStack(spacing: 13){
                        Image(systemName: "person.3")
                        Text("Groups")
                    }
                })
                NavigationLink(destination: GroupsView(), label: {
                    HStack(spacing: 27){
                        Image(systemName: "star")
                        Text("Rate Us")
                    }
                })
                NavigationLink(destination: GroupsView(), label: {
                    HStack(spacing: 30){
                        Image(systemName: "square.and.arrow.up")
                        Text("Share App")
                    }
                })
                NavigationLink(destination: GroupsView(), label: {
                    HStack(spacing: 38){
                        Image(systemName: "info")
                        Text("Privacy Policy")
                    }
                })
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .frame(width: width)
        .animation(.default, value: 10)
        .background(Color.primaryC)
    }
    
    var NavBarView: some View {
        VStack{
            HStack(spacing: 8){
                MenuButton
                Spacer()
                SearchBarView()
            }
        }
        .padding()
        .foregroundStyle(Color.white)
        .background(Color("secondaryC").ignoresSafeArea(edges: .top))
    }
    
    var MenuButton: some View {
        Button(action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    self.isDrawerOpen.toggle()
                }
            }
        }, label: {
            Image(systemName: "line.horizontal.3")
                .resizable()
                .frame(width: 18, height: 18)
        })
    }
    
    
    
}


#Preview {
    MainView()
}
