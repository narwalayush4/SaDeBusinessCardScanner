//
//  CellView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 02/11/24.
//

import SwiftUI

struct GroupCellView: View {
    var name: String
    var count: Int
    
    var body: some View {
            VStack {
                HStack {
                    Text("\(count)")
                        .fontDesign(.monospaced)
                        .font(.system(size: 40))
                        .foregroundStyle(.blue)
                    Spacer()
                }.padding(.horizontal).padding(.top)
                HStack {
                    Text(name)
                        .font(.title)
                    Spacer()
                }
                .padding(.horizontal).padding(.bottom)
            }.background {
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .foregroundStyle(.white)
            }
    }
}
