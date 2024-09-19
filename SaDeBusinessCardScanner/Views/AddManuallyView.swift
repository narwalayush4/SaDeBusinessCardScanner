//
//  AddManuallyView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI


struct AddManuallyView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var isScannerPresented = false
    @Binding var scannedCard: CardModel
    let fileManager = FileSystem()
    @State private var image: UIImage? = nil
    
    var body: some View {
        ScrollView {
            VStack{
                if let scannedImage = image {
                    Image(uiImage: scannedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 400, height: 250)
                        .padding()
                        .background(.thickMaterial)
                        .overlay {
                            HStack{
                                Spacer()
                                VStack{
                                    Spacer()
                                    Button(action: {
                                        isScannerPresented = true
                                        debugPrint("Scanner Button Tapped")
                                    }) {
                                        Image(systemName: "qrcode.viewfinder")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color.black.opacity(0.5))
                                            .cornerRadius(22)
                                    }
                                }
                            }
                            .sheet(isPresented: $isScannerPresented, content: {
                                CardScannerView(completionHandler: {
                                    self.isScannerPresented = false
                                    image = self.fileManager.retrieveImage(from: scannedCard.timeStamp_) ?? UIImage()
                                }, scannedCard: $scannedCard, onCancel: {
                                    self.isScannerPresented = false
                                })
                            })
                            .padding()
                        }
                } else {
                    Image("logo_512x512")
                        .frame(width: 400, height: 250)
                        .background(.thickMaterial)
                        .overlay {
                            HStack{
                                Spacer()
                                VStack{
                                    Spacer()
                                    Button(action: {
                                        isScannerPresented = true
                                        print("Scanner Button Tapped")
                                    }) {
                                        Image(systemName: "qrcode.viewfinder")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color.black.opacity(0.5))
                                            .cornerRadius(22)
                                    }
                                }
                            }
                            .sheet(isPresented: $isScannerPresented, content: {
                                CardScannerView(completionHandler: {
                                    self.isScannerPresented = false
                                    
                                    if let scannedImage = self.fileManager.retrieveImage(from: scannedCard.timeStamp_) {
                                        // Update the image variable on the main thread
                                        DispatchQueue.main.async {
                                            self.image = scannedImage
                                            self.isScannerPresented = false
                                            self.scannedCard = scannedCard
                                        }
                                    }
                                    
                                }, scannedCard: $scannedCard, onCancel: {
                                    self.isScannerPresented = false
                                })
                            })
                            .padding()
                        }
                }
                Spacer(minLength: 15.0)
                VStack{
                    TextFieldWithDropdownView(title: "Name", text: $scannedCard.name_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Job Title", text: $scannedCard.jobTitle_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Company", text: $scannedCard.company_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Phone No", text: $scannedCard.phone_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Email", text: $scannedCard.email_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Address Line 1", text: $scannedCard.address1_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Address Line 2", text: $scannedCard.address2_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Address Line 3", text: $scannedCard.address3_, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Website", text: $scannedCard.website_, dropdownItems: $scannedCard.options)
                }
                .padding(20.0)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveCard(cardModel: scannedCard)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            })
            .background(Color("primaryC"))
            .navigationTitle("Card Details")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .automatic)
            .background(Color("secondaryC"))
        }
    }
}

extension AddManuallyView{
    
    func saveCard(cardModel: CardModel?) {
        
        let card = Card(context: moc)
        card.email_ = cardModel?.email_ ?? ""
        card.website_ = cardModel?.website_ ?? ""
        card.phone_ = cardModel?.phone_ ?? ""
        card.company_ = cardModel?.company_ ?? ""
        card.name_ =  cardModel?.name_ ?? ""
        card.jobTitle_ = cardModel?.jobTitle_ ?? ""
        card.address_ =  cardModel?.address1_.appending(cardModel?.address2_.appending(cardModel?.address3_ ?? "") ?? "") ?? ""
        card.timeStamp_ = cardModel?.timeStamp_ ?? Date()
        
        
        //TODO: CHANGE
//        PersistenceController.preview.save()
        PersistenceController.shared.save()
        
        print(card)
    }
}

#Preview {
    AddManuallyView(scannedCard: .constant(CardModel()))
}

