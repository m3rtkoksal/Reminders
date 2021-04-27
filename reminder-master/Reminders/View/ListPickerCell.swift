//
//  ListCell.swift
//  Reminders
//
//  Created by Mert Köksal on 22.04.2021.
//

import SwiftUI

struct ListPickerCell: View {
    
    let list: ListModel
    @State var isSelected: Bool = false
    var body: some View {
            HStack{
                Color(list.color)
                    .frame(width: 30, height: 30, alignment: .center)
                    .cornerRadius(15)
                Text(list.text)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                Spacer()
                Image(systemName: isSelected ? "checkmark" : "")
            }
    }
}

struct ListPickerCell_Previews: PreviewProvider {
    static var previews: some View {
        ListPickerCell(list: ListModel(color: "swatch_patina", text: "MK", reminders: []))
    }
}
