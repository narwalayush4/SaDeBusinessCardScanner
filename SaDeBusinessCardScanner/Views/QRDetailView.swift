//
//  QRDetailView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 21/09/24.
//

import SwiftUI

struct QRDetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Binding var scannedCard: Card
    
    var body: some View {
        ScrollView {
            VStack{
                Image("logo512x512")
                    .frame(width: 400, height: 250)
                    .background(.thickMaterial)
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
            .background(Color("primaryC"))
            .navigationTitle("Card Details")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .automatic)
            .background(Color("secondaryC"))
        }
    }
}
