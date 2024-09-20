//
//  QRDetailView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 21/09/24.
//

import SwiftUI

struct QRDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @Binding var scannedCard: CardModel
    
    var body: some View {
        ScrollView {
            VStack{
                Image("logo_512x512")
                    .frame(width: 400, height: 250)
                    .background(.thickMaterial)
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

extension QRDetailView {
    
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
