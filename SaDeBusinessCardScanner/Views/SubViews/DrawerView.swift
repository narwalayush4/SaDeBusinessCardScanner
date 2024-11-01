//
//  DrawerView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 31/10/24.
//

import SwiftUI
import StoreKit

struct DrawerView: View{
    
    private let width = UIScreen.main.bounds.width * 0.55
    @Binding var isDrawerOpen: Bool
    
    var body: some View {
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
                Button(action: {
                    isDrawerOpen = false
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: windowScene)
                    }
                }) {
                    HStack(spacing: 27){
                        Image(systemName: "star")
                        Text("Rate Us")
                    }
                }
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
    
}
