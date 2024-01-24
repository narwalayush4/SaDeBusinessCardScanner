//
//  GroupsView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 27/09/23.
//

import SwiftUI

struct GroupsView: View {
    
    @State private var isAlertPresented = false
    @State private var newGroupName: String = ""
    
    var body: some View {
        VStack(spacing: 10, content: {
//            HStack(spacing: 8){
//                Button(action: {}, label: {
//                    Image(systemName: "arrow.backward")
//                        .resizable()
//                        .frame(width: 18, height: 18)
//                        .padding()
//                })
//                Text("Groups")
//                    .font(.title)
//                Spacer()
//            }
//            .padding()
//            .foregroundStyle(Color.white)
//            .background(Color("secondaryC").ignoresSafeArea(edges: .all))
            HStack(spacing: 5) {
                CellView(name: "Family")
                CellView(name: "Business")
            }.safeAreaPadding(.horizontal)
            HStack {
                CellView(name: "Customer")
                CellView(name: "Office")
            }.safeAreaPadding(.horizontal)
            HStack {
                CellView(name: "Friends")
                CellView(name: "VIP")
            }.safeAreaPadding(.horizontal)
            HStack{
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                    .foregroundStyle(Color(uiColor: .lightGray))
                    .opacity(0.5)
                    .frame(height: 2)
                Text("Your Groups")
                    .foregroundStyle(Color(uiColor: .lightGray))
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                    .foregroundStyle(Color(uiColor: .lightGray))
                    .frame(height: 2)
                    .opacity(0.5)
            }.safeAreaPadding(.horizontal)
            Spacer()
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isAlertPresented = true
                }, label: {
                    Text("Create")
                })
            }
        })
        .background(Color("primaryC"))
    }
}

#Preview {
    GroupsView()
}

struct CellView:View {
    
    var name = ""
    
    var body:some View{
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 20,height: 20))
                .foregroundStyle(.white)
                .frame(height: UIScreen.main.bounds.height/7)
            VStack{
                HStack {
                    Text("00")
                        .fontDesign(.monospaced)
                        .font(.system(size: 40))
                        .foregroundStyle(.blue)
                    Spacer()
                }.padding(.horizontal)
                HStack {
                    Text(name)
                        .font(.system(size: 30, weight: .light, design: .rounded))
                    Spacer()
                }
                .padding(.horizontal)
            }//TODO: set the height to the mininmum required
        }
    }
}
