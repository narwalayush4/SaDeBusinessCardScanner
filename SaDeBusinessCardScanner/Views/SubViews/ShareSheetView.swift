//
//  ShareSheetView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 21/09/24.
//

import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

