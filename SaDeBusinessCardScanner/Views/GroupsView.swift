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
    @State private var groups: [Group] = [
        Group(name: "Family"),
        Group(name: "Business"),
        Group(name: "Customer"),
        Group(name: "Office"),
        Group(name: "Friends"),
        Group(name: "VIP")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ForEach(0..<3) { row in
                    HStack(spacing: 5) {
                        ForEach(0..<2) { col in
                            let index = row * 2 + col
                            if index < groups.count {
                                NavigationLink(destination: GroupDetailView(group: groups[index])) {
                                    GroupCellView(name: groups[index].name, count: groups[index].cards.count)
                                }
                            }
                        }
                    }.safeAreaPadding(.horizontal)
                }
                
                HStack {
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
            }
            .background(Color("primaryC"))
            .navigationTitle("Groups")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAlertPresented = true
                    }) {
                        Text("Create")
                    }
                }
            }
            .alert("Create New Group", isPresented: $isAlertPresented) {
                TextField("Group Name", text: $newGroupName)
                Button("Create") {
                    if !newGroupName.isEmpty {
                        groups.append(Group(name: newGroupName))
                        newGroupName = ""
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

#Preview {
    GroupsView()
}
