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
                                Text("Name: \(card.name_)")
                                Text("Company: \(card.company_)")
                                Text("Job Title: \(card.jobTitle_)")
                                Text("Phone: \(card.phone_)")
                                Text("Email: \(card.email_)")
                                Text("Website: \(card.website_)")
                                Text("Address: \(card.address_)")
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
               "N:\(card.name_)\n" +
               "ORG:\(card.company_)\n" +
               "TITLE:\(card.jobTitle_)\n" +
               "TEL:\(card.phone_)\n" +
               "EMAIL:\(card.email_)\n" +
               "URL:\(card.website_)\n" +
               "ADR:\(card.address_)\n" +
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
