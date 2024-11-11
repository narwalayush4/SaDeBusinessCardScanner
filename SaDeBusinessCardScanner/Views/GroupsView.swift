//
//  GroupsView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 27/09/23.
//

import SwiftUI
import SwiftData

struct GroupsView: View {
    
    @Query private var groups: [Group]
    @Environment(\.modelContext) private var modelContext
    
    @State private var isAlertPresented = false
    @State private var newGroupName: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 5) {
                        ForEach(groups) { group in
                            NavigationLink(destination: GroupDetailView(group: group)) {
                                GroupCellView(name: group.name, count: group.cards.count)
                            }
                        }
                    }.safeAreaPadding(.horizontal)
                    
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
            }
            .background(Color.primaryC)
            .navigationBarTitleDisplayMode(.large)
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
                        let newGroup = Group(name: newGroupName)
                        modelContext.insert(newGroup)
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
