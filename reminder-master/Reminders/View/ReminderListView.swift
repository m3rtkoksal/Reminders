//
//  ReminderList.swift
//  Reminders
//
//  Created by Mert Köksal on 24.04.2021.
//

import SwiftUI

struct ReminderListView: View {
    @State var reminders = [Reminder]()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ReminderList_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView(reminders: [Reminder(title: "Merhaba", notes: "not", date: Date(timeIntervalSince1970: 1056730041), list: ListModel(color: "", text: "First", reminders: []))])
    }
}
