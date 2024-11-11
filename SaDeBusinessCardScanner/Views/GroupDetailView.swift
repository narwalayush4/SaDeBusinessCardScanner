//
//  GroupDetailView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 02/11/24.
//

import SwiftUI

struct GroupDetailView: View {
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
            .navigationTitle(group.name)
            .toolbarTitleDisplayMode(.large)
        } else {
            Text("No cards in this group.")
                .font(.callout)
                .bold()
                .navigationTitle(group.name)
                .toolbarTitleDisplayMode(.large)
        }
    }
}
