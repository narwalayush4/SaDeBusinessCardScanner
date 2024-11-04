//
//  CardDetails.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 29/11/23.
//

import SwiftUI
import Contacts

struct CardDetailsView: View {
    
    var card: Card
    let screenWidth = UIScreen.main.bounds.size.width * 0.7
    @State private var isShowingShareSheet = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    private var image: UIImage {
        return FileSystem().fetchImage(card: card)
    }
    
    var body: some View {
        ScrollView {
            Section {
                ZStack{
                    VStack {
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color.primaryC)
                            .frame(height: 100)
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color.white)
                    }
                    VStack{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .padding(.horizontal)
                            .frame(width: screenWidth*(8/7), height: 200)
                            .background(.thickMaterial)
                            .presentationCornerRadius(10)
                        VStack(alignment: .leading){
                            Text(card.name)
                                .bold()
                            Text(card.company)
                            ZStack {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .foregroundStyle(Color.primaryC)
                                HStack{
                                    Button(action: { isShowingShareSheet = true }){
                                        VStack{
                                            Image(systemName: "square.and.arrow.up")
                                            Text("Share")
                                        }
                                        .frame(width: screenWidth*0.45)
                                    }
                                    Rectangle()
                                        .frame(width: 1)
                                    Button { addToContacts() } label: {
                                        VStack{
                                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                            Text("Add to Contacts")
                                        }
                                        .frame(width: screenWidth*0.55)
                                    }
                                }
                                .foregroundStyle(.blue)
                                .padding()
                            }
                        }
                        .padding()
                    }
                }
                .padding()
            }
            Spacer(minLength: 30)
            Section {
                VStack(alignment: .leading, spacing: 0){
                    Text("Contact Details")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.secondaryC)
                        .padding(.horizontal)
                    VStack(alignment: .leading){
                        Button {
                            if let url = URL(string: "tel:\(card.phone)"),
                               UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Mobile Number")
                                        .foregroundStyle(.tertiaryC)
                                    Text(card.phone)
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                                Image(systemName: "phone.fill")
                                    .foregroundStyle(Color.secondaryC)
                            }
                        }
                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.primaryC)
                        Button {
                            if let emailURL = URL(string: "mailto:\(card.email)") {
                                UIApplication.shared.open(emailURL)
                            }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Email")
                                        .foregroundStyle(.tertiaryC)
                                    Text(card.email)
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                                Image(systemName: "envelope.fill")
                                    .foregroundStyle(Color.secondaryC)
                            }
                        }

                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.primaryC)
                        Button {
                            if let websiteURL = URL(string: "https://\(card.website)") {
                                UIApplication.shared.open(websiteURL)
                            }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Website")
                                        .foregroundStyle(.tertiaryC)
                                    Text(card.website)
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                                Image(systemName: "globe")
                                    .foregroundStyle(Color.secondaryC)
                            }
                        }

                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)

                }
            }
            Spacer(minLength: 15)
            Section {
                VStack(alignment: .leading, spacing: 0){
                    Text("Address")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.secondaryC)
                        .padding(.horizontal)
                    VStack(alignment: .leading){
                        Button {
                            if let mapURL = URL(string: "http://maps.apple.com/?address=\(card.fullAddress)") {
                                        UIApplication.shared.open(mapURL)
                                    }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text(card.fullAddress)
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundStyle(Color.secondaryC)
                            }
                        }

                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)

                }
            }
            Spacer(minLength: 15)
            HStack {
                Text("Groups")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.secondaryC)
                    .padding(.horizontal)
                Spacer()
                Button {
                    //TODO: Add to group
                    //Add to group
                } label: {
                    Text("Add to Group")
                        .foregroundStyle(Color.white)
                        .bold()
                        .padding(5.0)
                        .background {
                            RoundedRectangle(cornerRadius: 5.0)
                                .fill(Color.secondaryC)
                        }
                }
            }
            .padding(.trailing)
            Spacer(minLength: 15)
            Section {
                VStack(alignment: .leading, spacing: 0){
                    Text("Other Details")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.secondaryC)
                        .padding(.horizontal)
                    VStack(alignment: .leading){
                        HStack{
                            VStack(alignment: .leading){
                                Text("Company")
                                    .foregroundStyle(.tertiaryC)
                                Text(card.company)
                            }
                            Spacer()
                        }
                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.primaryC)
                        HStack{
                            VStack(alignment: .leading){
                                Text("Job Title")
                                    .foregroundStyle(.tertiaryC)
                                Text(card.jobTitle)
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)

                }
            }
        }
        .sheet(isPresented: $isShowingShareSheet, onDismiss: {
            isShowingShareSheet = false
        }, content: {
            ShareSheetView(activityItems: [card.name, image])
                .presentationDetents([.medium])
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink(destination: ShareCardWithQrView(card: card)) {
                    Image(systemName: "qrcode")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: EditView(card: card)) {
                    Image(systemName: "pencil")
                }
            }
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Contact Status"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    showAlert = false
                }
            )
        }
        .frame(maxWidth: .infinity)
        .background(Color.primaryC)
    }
}

extension CardDetailsView {
    
    private func addToContacts() {
        let newContact = CNMutableContact()
        newContact.givenName = card.name
        if !card.phone.isEmpty {
            let phoneNumber = CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: card.phone))
            newContact.phoneNumbers = [phoneNumber]
        }
        if !card.email.isEmpty {
            let email = CNLabeledValue(label: CNLabelHome, value: card.email as NSString)
            newContact.emailAddresses = [email]
        }
        newContact.jobTitle = card.jobTitle
        newContact.organizationName = card.company
        if !card.website.isEmpty {
            let urlAddress = CNLabeledValue(label: CNLabelURLAddressHomePage, value: card.website as NSString)
            newContact.urlAddresses = [urlAddress]
        }
        if !card.fullAddress.isEmpty {
            let homeAddress = CNMutablePostalAddress()
            let addressComponents = card.fullAddress.components(separatedBy: ",")
            if addressComponents.count >= 3 {
                homeAddress.street = addressComponents[0].trimmingCharacters(in: .whitespaces)
                homeAddress.city = addressComponents[1].trimmingCharacters(in: .whitespaces)
                let stateZip = addressComponents[2].trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
                if stateZip.count >= 2 {
                    homeAddress.state = stateZip[0]
                    homeAddress.postalCode = stateZip[1]
                }
            } else {
                homeAddress.street = card.fullAddress
            }
            newContact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAddress)]
        }

        
        let store = CNContactStore()
        let request = CNSaveRequest()
        request.add(newContact, toContainerWithIdentifier: nil)
        do {
            try store.execute(request)
            alertMessage = "Contact saved successfully"
        } catch {
            alertMessage = "Error saving contact: \(error.localizedDescription)"
        }
        showAlert = true
    }
}

#Preview {
    return CardDetailsView(card: Card.shared)
}
