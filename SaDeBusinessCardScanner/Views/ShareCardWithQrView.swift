//
//  ShareCardWithQrView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 01/11/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ShareCardWithQrView: View {
    var card: Card
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
            ScrollView {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.1))
                        .padding(10)
                    VStack {
                        VStack {
                            Image(uiImage: UIImage(named: "person")!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.top)
                            
                            VStack(alignment: .leading) {
                                Text("Name: \(card.name)")
                                Text("Company: \(card.company)")
                                Text("Job Title: \(card.jobTitle)")
                                Text("Phone: \(card.phone)")
                                Text("Email: \(card.email)")
                                Text("Website: \(card.website)")
                                Text("Address: \(card.address)")
                            }
                            .padding()
                        }
                        Image(uiImage: generateQRCode(from: createVCardString()))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)

                }
            }
    }
}

extension ShareCardWithQrView {
    
    private func createVCardString() -> String {
        return "BEGIN:VCARD\nVERSION:3.0\n" +
               "N:\(card.name)\n" +
               "ORG:\(card.company)\n" +
               "TITLE:\(card.jobTitle)\n" +
               "TEL:\(card.phone)\n" +
               "EMAIL:\(card.email)\n" +
               "URL:\(card.website)\n" +
               "ADR:\(card.address)\n" +
               "END:VCARD"
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct ShareCardWithQrView_Previews: PreviewProvider {
    static var previews: some View {
        ShareCardWithQrView(card: Card.shared)
    }
}
