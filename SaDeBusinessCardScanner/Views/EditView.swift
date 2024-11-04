//
//  EditView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 28/11/23.
//

import SwiftUI

struct EditView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State private var isAlertPresented = false
    @State var card: Card
    let fileManager = FileSystem()
    private var image: UIImage {
        return FileSystem().fetchImage(card: card)
    }
    
    var body: some View {
        ScrollView {
            VStack{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 250)
                    .padding()
                    .background(.thickMaterial)
                Spacer(minLength: 15.0)
                VStack{
                    TextFieldWithOutDropdownView(title: "Name", text: $card.name)
                    TextFieldWithOutDropdownView(title: "Job Title", text: $card.jobTitle)
                    TextFieldWithOutDropdownView(title: "Company", text: $card.company)
                    TextFieldWithOutDropdownView(title: "Phone No", text: $card.phone)
                    TextFieldWithOutDropdownView(title: "Email", text: $card.email)
                    TextFieldWithOutDropdownView(title: "Address Line 1", text: $card.address1)
                    TextFieldWithOutDropdownView(title: "Address Line 2", text: $card.address2)
                    TextFieldWithOutDropdownView(title: "Address Line 3", text: $card.address3)
                    TextFieldWithOutDropdownView(title: "Website", text: $card.website)
                }
                .padding(20.0)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertPresented = true
                    } label: {
                        Text("Delete")
                            .foregroundStyle(Color.red)
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            })
            .alert("Delete Card", isPresented: $isAlertPresented, actions: {
                Button("Delete", role: .destructive) {
                    modelContext.delete(card)
                    self.presentationMode.wrappedValue.dismiss()
                }
                Button("Cancel", role: .cancel) {
                    isAlertPresented.toggle()
                }
            }, message: {
                Text("Are you sure you want to delete this card?")
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
    return EditView(card: Card.shared)
}



