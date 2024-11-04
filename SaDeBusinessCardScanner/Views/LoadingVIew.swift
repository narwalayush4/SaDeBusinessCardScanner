//
//  LoadingVIew.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 04/01/24.
//

import SwiftUI

struct LoadingVIew: View {
    var body: some View {
        VStack {
            // Add your loading indicator or logo here
            Image(Assets.Images.logo512x512)
                .resizable()
                .frame(width: 200, height: 200)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            Text("Loading...")
                .font(.headline)
                .padding(.top, 10)
        }
        .padding()
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    LoadingVIew()
}
