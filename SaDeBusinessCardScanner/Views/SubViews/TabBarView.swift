//
//  TabBarView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 24/09/23.
//

import SwiftUI
import CodeScanner


struct TabBarView: View {
    
    @Environment(\.managedObjectContext) var moc
    let screenWidth = UIScreen.main.bounds.size.width * 0.9
    @State private var isCardDetailModifierPresented = false
    @State private var scannedCard = Card()
    @State private var isQRCodeScannerPresented: Bool = false
    @State private var isAlertPresented = false
    @State private var showQRDetailView: Bool = false
    @State private var alertErrorText = ""
    
    var body: some View {
        NavigationStack {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: screenWidth, height: 80)
                    .foregroundStyle(Color("secondaryC"))
                HStack{
                    Button(action: {
                        isQRCodeScannerPresented = true
                    }, label: {
                        VStack(alignment: .center) {
                            Image(systemName: "qrcode.viewfinder")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("QR Code")
                                .font(.callout)
                        }
                        .frame(width: screenWidth/3)
                        .foregroundStyle(Color("primaryC"))
                    })
                    NavigationLink(destination: AddManuallyView(isScannerPresented: true)) {
                        VStack(alignment: .center) {
                            Image(systemName: "doc.viewfinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("Business Card")
                                .font(.callout)
                        }
                        .frame(width: screenWidth/3)
                        .foregroundStyle(Color("primaryC"))
                    }
                    NavigationLink(destination: AddManuallyView()) {
                        VStack(alignment: .center) {
                            Image("card")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("Create Manually")
                                .font(.footnote)
                        }
                        .padding()
                        .frame(width: screenWidth/3)
                        .foregroundStyle(Color("primaryC"))
                    }
                }
                .sheet(isPresented: self.$isQRCodeScannerPresented, content: {
                    CodeScannerView(codeTypes: [.qr], showViewfinder: true, completion: { response in
                        switch response {
                        case .success(let result):
                            print("Found code: \(result.string)")
                            isQRCodeScannerPresented = false
                            if parseContactData(qrCodeText: result.string) {
                                showQRDetailView = true
                            } else {
                                alertErrorText = "QR Code is not of the Contact card format."
                                DispatchQueue.main.async { isAlertPresented = true }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            isAlertPresented = true
                            alertErrorText = error.localizedDescription
                        }
                    })
                })
                .fullScreenCover(isPresented: $showQRDetailView, content: {
                    NavigationStack{
                        QRDetailView(scannedCard: $scannedCard)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Back") {
                                        showQRDetailView = false
                                    }
                                }
                            }
                    }
                })
                .alert(isPresented: $isAlertPresented) {
                    Alert(
                        title: Text("Invalid QR Code"),
                        message: Text(alertErrorText),
                        dismissButton: .default(Text("OK"), action: { isAlertPresented = false })
                    )
                }
                
                HStack{
                    Rectangle()
                        .foregroundStyle(Color.clear)
                        .frame(width: screenWidth/3 - 1, height: 80)
                    Rectangle()
                        .frame(width: 1, height: 55)
                        .foregroundStyle(Color("primaryC"))
                    Rectangle()
                        .foregroundStyle(Color.clear)
                        .frame(width: screenWidth/3 - 1, height: 80)
                    Rectangle()
                        .frame(width: 1, height: 55)
                        .foregroundStyle(Color("primaryC"))
                    Rectangle()
                        .foregroundStyle(Color.clear)
                        .frame(width: screenWidth/3 - 1, height: 80)
                    
                }
            }
        }
    }
    
    //MARK: - Scanned vCard/MeCard Parsing
    func parseContactData(qrCodeText: String) -> Bool{
        if qrCodeText.hasPrefix("BEGIN:VCARD") {
            parseVCard(vCard: qrCodeText)
            return true
        } else if qrCodeText.hasPrefix("MECARD:") {
            parseMeCard(meCard: qrCodeText)
            return true
        }
        return false
    }

    func parseVCard(vCard: String) {
        let lines = vCard.split(separator: "\n")
        
        for line in lines {
            if line.hasPrefix("FN:") {
                let name = line.replacingOccurrences(of: "FN:", with: "")
                scannedCard.name = name
            } else if line.hasPrefix("ORG:") {
                let company = line.replacingOccurrences(of: "ORG:", with: "")
                scannedCard.company = company
            } else if line.hasPrefix("TITLE:") {
                let jobTitle = line.replacingOccurrences(of: "TITLE:", with: "")
                scannedCard.jobTitle = jobTitle
            } else if line.hasPrefix("TEL:") {
                let phone = line.replacingOccurrences(of: "TEL:", with: "")
                scannedCard.phone = phone
            } else if line.hasPrefix("EMAIL:") {
                let email = line.replacingOccurrences(of: "EMAIL:", with: "")
                scannedCard.email = email
            } else if line.hasPrefix("ADR:") {
                let addressComponents = line.replacingOccurrences(of: "ADR:", with: "").split(separator: ";")
                if addressComponents.count >= 3 {
                    scannedCard.address1_ = String(addressComponents[0])
                    scannedCard.address2_ = String(addressComponents[1])
                    scannedCard.address3_ = String(addressComponents[2])
                }
            } else if line.hasPrefix("URL:") {
                let website = line.replacingOccurrences(of: "URL:", with: "")
                scannedCard.website = website
            }
        }
    }

    func parseMeCard(meCard: String) {
        let meCardString = meCard.replacingOccurrences(of: "MECARD:", with: "")
        let fields = meCardString.split(separator: ";")
        
        for field in fields {
            if field.hasPrefix("N:") {
                let name = field.replacingOccurrences(of: "N:", with: "")
                scannedCard.name = name
            } else if field.hasPrefix("ORG:") {
                let company = field.replacingOccurrences(of: "ORG:", with: "")
                scannedCard.company = company
            } else if field.hasPrefix("TEL:") {
                let phone = field.replacingOccurrences(of: "TEL:", with: "")
                scannedCard.phone = phone
            } else if field.hasPrefix("EMAIL:") {
                let email = field.replacingOccurrences(of: "EMAIL:", with: "")
                scannedCard.email = email
            } else if field.hasPrefix("ADR:") {
                let addressComponents = field.replacingOccurrences(of: "ADR:", with: "").split(separator: ",")
                if addressComponents.count >= 3 {
                    scannedCard.address1_ = String(addressComponents[0])
                    scannedCard.address2_ = String(addressComponents[1])
                    scannedCard.address3_ = String(addressComponents[2])
                }
            } else if field.hasPrefix("URL:") {
                let website = field.replacingOccurrences(of: "URL:", with: "")
                scannedCard.website = website
            }
        }
        print("this is mecard\(scannedCard)")
    }
}

#Preview {
    TabBarView()
}
