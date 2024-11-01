//
//  CellView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 02/11/24.
//

import SwiftUI

struct GroupCellView: View {
    var name = ""
    var count = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .foregroundStyle(.white)
                .frame(height: UIScreen.main.bounds.height/7)
            VStack {
                HStack {
                    Text("\(count)")
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
            }
        }
    }
}
