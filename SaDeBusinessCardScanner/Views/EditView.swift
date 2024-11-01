//
//  EditView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 28/11/23.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var isAlertPresented = false
    @State var card: Card
    let fileManager = FileSystem()
    private var image: UIImage {
        fileManager.retrieveImage(from: card.timeStamp_) ?? UIImage()
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
                    TextFieldWithOutDropdownView(title: "Name", text: $card.name_)
                    TextFieldWithOutDropdownView(title: "Job Title", text: $card.jobTitle_)
                    TextFieldWithOutDropdownView(title: "Company", text: $card.company_)
                    TextFieldWithOutDropdownView(title: "Phone No", text: $card.phone_)
                    TextFieldWithOutDropdownView(title: "Email", text: $card.email_)
                    TextFieldWithOutDropdownView(title: "Address", text: $card.address_)
                    TextFieldWithOutDropdownView(title: "Website", text: $card.website_)
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
                        debugPrint("during edit view presentatioMode is: \(presentationMode)")
                        isAlertPresented = true
                    } label: {
                        Text("Delete")
                            .foregroundStyle(Color.red)
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        presentationMode.wrappedValue.dismiss()
                        PersistenceController.shared.save()
                    }
                }
            })
            .alert("Delete Card", isPresented: $isAlertPresented, actions: {
                Button("Delete", role: .destructive) {
                    debugPrint("before dismiss")
                    self.presentationMode.wrappedValue.dismiss()
                    debugPrint("after dismiss")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  
                        // Delay for view dismissal
                        PersistenceController.shared.delete(card: card)
                        debugPrint("after saving")
                    }
                }
                Button("Cancel", role: .cancel) {
                    isAlertPresented.toggle()
                }
            }, message: {
                Text("Are you sure you want to delete this card?")
            })
            .background(Color("primaryC"))
            .navigationTitle("Card Details")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.visible, for: .automatic)
            .background(Color("secondaryC"))
        }
    }
}


#Preview {
    return EditView(card: Card.shared)
}



