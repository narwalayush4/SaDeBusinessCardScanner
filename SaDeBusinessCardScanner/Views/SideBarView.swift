//
//  SideBarView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 30/09/23.
//

import SwiftUI

struct SideBarView: View {
    
    @Binding var isDrawerOpen: Bool
    private let width = UIScreen.main.bounds.width * 0.4
    //    var content: AnyView
    //    var edgeTransition: AnyTransition = .move(edge: .leading)
    
    
    var body: some View {
        HStack{
            Color.blue
                .ignoresSafeArea(.all)
                .frame(width: self.width)
                .offset(x: self.isDrawerOpen ? 0 : -self.width)
            Spacer()
        }
    }
}

#Preview {
    SideBarView(isDrawerOpen: .constant(true))
}
