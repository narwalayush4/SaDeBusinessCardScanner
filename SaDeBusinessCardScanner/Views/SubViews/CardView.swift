//
//  CardView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI
import CoreData

struct CardView: View {
    
    let fileManager = FileSystem()
    @State var card: Card
    @State private var isEditing = false
    @State private var isAlertPresented = false
    @State private var isShowingShareSheet = false
    private var image: UIImage {
        return card.fetchImage(fileManager: fileManager)
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink(destination: CardDetailsView(card: card)){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipped()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(card.name_)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(card.company_)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    .padding()
                    Spacer()
                    Button(action: {
                        isShowingShareSheet = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 22, height: 30)
                            .offset(y: -2)
                            .foregroundStyle(.blue)
                    }
                    Menu {
                        NavigationLink(destination: EditView(card: card)) {
                            Text("Edit")
                        }
                        Button("Delete") {
                            isAlertPresented.toggle()
                        }
                        Button("Add to Group") {
                            // Perform add to group action
                            isAlertPresented.toggle()
                        }
                        
                        Button("Add to Contacts") {
                            // Perform add to group action
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.blue)
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $isShowingShareSheet, onDismiss: {
                isShowingShareSheet = false
            }, content: {
                ShareSheetView(activityItems: [card.name_, image])
                    .presentationDetents([.medium])
            })
            .alert("Delete Card", isPresented: $isAlertPresented, actions: {
                Button("Delete", role: .destructive) {
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
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
        }
    }
}

#Preview {
    return CardView(card: Card.shared)
}
