//
//  ListPickerView.swift
//  Reminders
//
//  Created by Mert Köksal on 22.04.2021.
//

import SwiftUI

struct ListPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isAddList = false
    @Binding var lists : [ListModel]
    @Binding var selectedList : ListModel
    var body: some View {
        Form {
            ForEach(lists, id: \.self) { list in
                Button(action: {
                    self.selectedList = list
                    print(selectedList)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    ListPickerCell(list: list)
                }
            }
        }
    .navigationBarTitle(Text("Yeni Animsatici"), displayMode: .inline)
}

static func makeListDefaults() -> [ListModel] {
    let sharknado = ListModel(
        color: "swatch_patina", text: "Sharknado", reminders: [])
    let kungPow = ListModel(
        color: "swatch_patina", text: "Kung Pow: Enter the Fist", reminders: [])
    
    return [sharknado, kungPow]
}
}

struct ListPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ListPickerView(lists: .constant([ListModel(color: "swatch_japonica", text: "2", reminders: [])]), selectedList: .constant(ListModel(color: "swatch_tussock", text: "baba", reminders: [])))
    }
}
