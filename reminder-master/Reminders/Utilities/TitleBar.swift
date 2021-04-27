//
//  SearchBar.swift
//  Hamur Delivery
//
//  Created by Mert Köksal on 1.03.2021.
//

import SwiftUI
 
struct TitleBar: View {
    @Binding var title: String
 
    @State private var isEditing = false
 
    var body: some View {
        ZStack {
            TextField("", text: $title)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .overlay(
                    HStack {
                        Image(systemName: "")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.title = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }
        .frame(width: UIScreen.main.bounds.width / (375 / 335))
        .padding(.top)
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar(title: .constant(""))
    }
}
