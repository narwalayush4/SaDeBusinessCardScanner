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
    @State private var isCardDetailModifierPresented = false
    @State private var scannedCard = CardModel()
    @State private var isQRCodeScannerPresented: Bool = false
    let screenWidth = UIScreen.main.bounds.size.width * 0.9
    
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
//                    NavigationLink(destination: ) {
//                        VStack(alignment: .center) {
//                            Image(systemName: "qrcode.viewfinder")
//                                .resizable()
//                                .frame(width: 25, height: 25)
//                            Text("QR Code")
//                                .font(.callout)
//                        }
//                        .frame(width: screenWidth/3)
//                        .foregroundStyle(Color("primaryC"))
//                    }
                    Button(action: {
//                        isScannerPresented = true
                    }, label: {
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
                    })
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
                    CodeScannerView(codeTypes: [.qr], completion: { response in
                        switch response {
                        case .success(let result):
                            print("Found code: \(result.string)")
                            isQRCodeScannerPresented = false
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                })
//                .sheet(isPresented: self.$isScannerPresented, content: {
//                    CardScannerView(completionHandler: { cardData in
//                        if let data = cardData {
////                            let card = Card(context: managedObjectContext,
////                                            email: data.email,
////                                            website: data.website,
////                                            phone:data.phone,
////                                            company: data.company,
////                                            name: data.name,
////                                            jobTitle: data.jobTitle,
////                                            address1: data.address1,
////                                            address2: data.address2,
////                                            address3: data.address3,
////                                            timeStamp: data.timeStamp,
////                                            filePath: data.filePath)
//                            let card = Card(context: moc)
//                            card.email_ = data.email_
//                            card.website_ = data.website_
//                            card.phone_ = data.phone_
//                            card.company_ = data.company_
//                            card.name_ =  data.name_
//                            card.jobTitle_ = data.jobTitle_
//                            card.address1_ =  data.address1_
//                            card.address2_ = data.address2_
//                            card.address3_ = data.address3_
//                            card.timeStamp_ = data.timeStamp_
//                            card.filePath_ = data.filePath_
//                            
//                            self.scannedCard = card
//                            
//                            //TODO: CHANGE
//                            PersistenceController.preview.save()
//                            
//                            print(card.website_ )
//                            print(card.email_)
//                            print(card.phone_)
//                            print(card)
//                        }
//                        self.isScannerPresented = false
//                        self.isCardDetailModifierPresented = true
//                    }, onCancel: {
//                        self.isScannerPresented = false
//                    })
//                })
//                .sheet(isPresented: self.$isScannerPresented, content: {
//                    CardScannerView(completionHandler: {
//                        self.isScannerPresented = false
//                        self.isCardDetailModifierPresented = true
//                    }, scannedCard: $scannedCard) {
//                        self.isScannerPresented = false
//                    }
//                })
//                .sheet(isPresented: self.$isCardDetailModifierPresented, content: {
//                    NavigationView(content: {
//                        EditView(card: scannedCard)
//                    })
//                })
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
}

//#Preview {
//    TabBarView(, scannedCard: Card())
//}



//                                VStack(alignment: .center, spacing: 6) {
//                                    Image(systemName: "qrcode.viewfinder")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 25, height: 25)
//                                    Text("QR Code")
//                                        .font(.footnote)
//                                }
//                                .padding(.vertical, 10)
//                                .foregroundStyle(.black)


//                            Button {
//                                //                QRScannerView()
//                                //                    $viewModel.selectedTab = 1
//                            } label: {
//                                VStack(alignment: .center, spacing: 6) {
//                                    Image(systemName: "qrcode.viewfinder")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 25, height: 25)
//                                    Text("QR Code")
//                                        .font(.callout)
//                                }
//                                .padding(.vertical, 10)
//                                .foregroundStyle(Color("primaryC"))
//                            }

//                            Button {
//                                //open cards
//                                //                        $viewModel.selectedTab = 2
//
//                            } label: {
//                                VStack(alignment: .center, spacing: 6) {
//                                    Image("card-scan2")
//                                        .renderingMode(.original)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 50, height: 50)
//                                    Text("Business Card")
//                                        .font(.system(size: 14))
//                                        .offset(y: -10)
//                                }
//                                .padding(.vertical)
//                                .foregroundStyle(Color("primaryC"))
//                            }
//                            .foregroundStyle(.black)

//                                VStack(alignment: .center, spacing: 6) {
//                                    Image("card")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 25, height: 25)
//                                    Text("Create Manually")
//                                        .font(.footnote)
//                                }
//                                .padding(.vertical, 10)
//                                .foregroundStyle(.black)

//                            Button {
//                                //go to create manually
//                                //                    selectedTab = 3
//                            } label: {
//
//                                VStack(alignment: .center, spacing: 6) {
//                                    Image("card")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 25, height: 25)
//                                    Text("Create Manually")
//                                        .font(.footnote)
//                                }
//                                .foregroundStyle(Color("primaryC"))
//                            }
