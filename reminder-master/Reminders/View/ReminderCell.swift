//
//  ReminderCell.swift
//  Reminders
//
//  Created by Mert Köksal on 24.04.2021.
//

import SwiftUI

struct ReminderCell: View {
    let reminder: Reminder
    static let releaseFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter
    }()
    var body: some View {
        VStack(alignment: .leading) {
          Text(reminder.title)
            .font(.title)
            Text(reminder.list.text)
          HStack {
            Text(reminder.notes)
              .font(.caption)
            Spacer()
            Text(Self.releaseFormatter.string(from: reminder.date))
              .font(.caption)
          }
        }
        .padding()  
    }
}

struct ReminderCell_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCell(reminder: Reminder(title: "Merhaba", notes: "not", date: Date(timeIntervalSince1970: 1056730041), list: ListModel(color: "", text: "First", reminders: [])))
    }
}
