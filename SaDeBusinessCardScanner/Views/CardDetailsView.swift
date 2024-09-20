//
//  CardDetails.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 29/11/23.
//

import SwiftUI

struct CardDetailsView: View {
    
    var card: Card
    let fileManager = FileSystem()
    let screenWidth = UIScreen.main.bounds.size.width * 0.7
    private var image: UIImage {
        return fileManager.retrieveImage(from: card.timeStamp_) ?? UIImage("logo_512x512")
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
                            Text(card.name_)
                                .bold()
                            Text(card.company_)
                            ZStack {
                                RoundedRectangle(cornerRadius: 10.0)
                                    .foregroundStyle(Color.primaryC)
                                HStack{
                                    VStack{
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Share")
                                    }
                                    .frame(width: screenWidth*0.45)
                                    Rectangle()
                                        .frame(width: 1)
                                    VStack{
                                        Image(systemName: "person.crop.circle.fill.badge.plus")
                                        Text("Add to Contacts")
                                    }
                                    .frame(width: screenWidth*0.55)
                                }
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
                            if let url = URL(string: "tel:\(card.phone_)"),
                               UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Mobile Number")
                                        .foregroundStyle(.tertiaryC)
                                    Text(card.phone_)
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
                            if let emailURL = URL(string: "mailto:\(card.email_)") {
                                UIApplication.shared.open(emailURL)
                            }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Email")
                                        .foregroundStyle(.tertiaryC)
                                    Text(card.email_)
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
                            if let websiteURL = URL(string: "https://\(card.website_)") {
                                UIApplication.shared.open(websiteURL)
                            }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Website")
                                        .foregroundStyle(.tertiaryC)
                                    Text(card.website_)
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
                            if let mapURL = URL(string: "http://maps.apple.com/?address=\(card.address_)") {
                                        UIApplication.shared.open(mapURL)
                                    }
                        } label: {
                            HStack{
                                VStack(alignment: .leading){
                                    Text(card.address_)
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
                                Text(card.company_)
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
                                Text(card.jobTitle_)
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
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink(destination: EditView(card: card)) {
                    Image(systemName: "qrcode")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: EditView(card: card)) {
                    Image(systemName: "pencil")
                }
            }
        })
        .frame(maxWidth: .infinity)
        .background(Color.primaryC)
    }
}

#Preview {
//    let previewContext = PersistenceController.preview.container.viewContext
//    let card = Card(context: previewContext)
//    card.name_ = "John Doe"
//    card.company_ = "Example Company"
//    card.jobTitle_ = "Software Engineer"
//    card.email_ = "john.doe@example.com"
//    card.phone_ = "1234567890"
//    card.website_ = "www.example.com"
//    card.address_ = "123 Main Street"
//    card.timeStamp_ = Date(timeIntervalSince1970: 60000)

    return CardDetailsView(card: Card.shared)
}
