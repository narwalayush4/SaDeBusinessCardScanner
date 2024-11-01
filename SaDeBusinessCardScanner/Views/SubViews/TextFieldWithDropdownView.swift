//
//  TextFieldView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/10/23.
//

import SwiftUI

struct TextFieldWithDropdownView: View{
    
    var title: String
    @Binding var text: String
    @Binding var dropdownItems: [String]
    
    var body: some View{
        VStack{
            HStack{
                Text(title)
                Spacer()
            }
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color("primaryC"))
                .frame(height: 50)
                .overlay {
                    HStack{
                        TextField(title, text: $text)
                            .padding()
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Spacer()
                        Menu {
                            ForEach(dropdownItems, id: \.self) { item in
                                        Button(item) {
                                            text = item
                                        }
                                    }
                        } label: {
                            Image(systemName: "chevron.down")
                                .padding()
                        }

                    }
                }
        }
        .padding()
    }
}


#Preview {
    TextFieldWithDropdownView(title: "Name",text: .constant("enter text here"), dropdownItems: .constant(["1", "2", "3"]))
}
