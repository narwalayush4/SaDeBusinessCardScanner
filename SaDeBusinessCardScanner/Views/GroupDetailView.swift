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
        Text(group.name)
            .navigationTitle(group.name)
            .toolbarTitleDisplayMode(.large)
    }
}
