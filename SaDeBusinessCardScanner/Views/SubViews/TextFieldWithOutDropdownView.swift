//
//  TextFieldView.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/10/23.
//

import SwiftUI

struct TextFieldWithOutDropdownView: View{
    
    var title: String
    @Binding var text: String
    
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
                    TextField(title, text: $text)
                        .padding()
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
        }
        .padding()
    }
}


#Preview {
    TextFieldWithOutDropdownView(title: "Name", text: .constant("enter text here"))
}
