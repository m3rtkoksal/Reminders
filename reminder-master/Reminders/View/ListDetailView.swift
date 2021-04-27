//
//  ListDetailView.swift
//  Reminders
//
//  Created by Mert Köksal on 27.04.2021.
//

import SwiftUI

struct ListDetailView: View {
    @Binding var list : ListModel
    var body: some View {
        ForEach(list.reminders, id: \.self) { reminder in
            ReminderCell(reminder: reminder)
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(list: .constant(ListModel(color: "", text: "", reminders: [])))
    }
}
