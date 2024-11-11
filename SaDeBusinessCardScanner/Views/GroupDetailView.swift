//
//  GroupDetailView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 02/11/24.
//

import SwiftUI

struct GroupDetailView: View {
    var group: Group
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var showDeleteConfirmationDialog: Bool = false
    
    var body: some View {
        GroupSubView(group: group)
            .navigationTitle(group.name)
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: {
                        showDeleteConfirmationDialog = true
                    }, label: {
                        Text("Delete").foregroundStyle(.red)
                    })
                }
            }
            .alert("Are you sure you want to delete this group?", isPresented: $showDeleteConfirmationDialog) {
                Button("Delete", role: .destructive) {
                    modelContext.delete(group)
                    dismiss()
                }
                Button("Cancel", role: .cancel) { showDeleteConfirmationDialog = false }
            }
    }
}

fileprivate struct GroupSubView: View {
    var group: Group
    
    var body: some View {
        if !group.cards.isEmpty {
            ScrollView {
                VStack {
                    ForEach(group.cards) { card in
                        CardView(card: card)
                    }
                }
            }
            .background(Color.primaryC)
        } else {
            ZStack {
                Color.primaryC.edgesIgnoringSafeArea(.all)
                Text("No cards in this group.")
                    .font(.callout)
                    .bold()
            }
        }
    }
}
