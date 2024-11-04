//
//  AddManuallyView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI


struct AddManuallyView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var isScannerPresented = false
    @State private var scannedCard = Card()
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
                                    image = self.fileManager.retrieveImage(from: scannedCard.timeStamp) ?? UIImage()
                                }, scannedCard: $scannedCard, onCancel: {
                                    self.isScannerPresented = false
                                })
                            })
                            .padding()
                        }
                } else {
                    Image(Assets.Images.logo512x512)
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
                                    
                                    if let scannedImage = self.fileManager.retrieveImage(from: scannedCard.timeStamp) {
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
                    TextFieldWithDropdownView(title: "Name", text: $scannedCard.name, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Job Title", text: $scannedCard.jobTitle, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Company", text: $scannedCard.company, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Phone No", text: $scannedCard.phone, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Email", text: $scannedCard.email, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Address Line 1", text: $scannedCard.address1, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Address Line 2", text: $scannedCard.address2, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Address Line 3", text: $scannedCard.address3, dropdownItems: $scannedCard.options)
                    TextFieldWithDropdownView(title: "Website", text: $scannedCard.website, dropdownItems: $scannedCard.options)
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
                        modelContext.insert(scannedCard)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            })
            .background(Color.primaryC)
            .navigationTitle("Card Details")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .automatic)
            .background(Color.secondaryC)
        }
    }
}

#Preview {
    AddManuallyView()
}

