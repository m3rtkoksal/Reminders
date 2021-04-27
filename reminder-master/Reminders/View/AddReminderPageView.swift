//
//  AddReminderPageView.swift
//  Reminders
//
//  Created by Mert Köksal on 22.04.2021.
//

import SwiftUI

struct AddReminderPageView: View {
    static let DefaultReminderTitle = "An untitled reminder"
    static let DefaultReminderNote = "Genre-buster"
    static let DefaultList = ListModel(color: "", text: "Default", reminders: [])
    @State var isSelectList = false
    @State var title = ""
    @State var note = ""
    @State var releaseDate = Date()
    @Binding var lists : [ListModel]
    @State var list = ListModel(color: "", text: "", reminders: [])
    let onComplete: (String, String, Date, ListModel) -> Void

    var body: some View {
        NavigationView {
        Form {
          Section(header: Text("Title")) {
            TextField("Title", text: $title)
          }
          Section(header: Text("Note")) {
            TextField("Note", text: $note)
          }
          Section {
            DatePicker(
              selection: $releaseDate,
              displayedComponents: .date) { Text("Release Date").foregroundColor(Color(.gray)) }
          }
            Section(header: Text("Liste")) {
                NavigationLink(
                    destination: ListPickerView(lists: $lists, selectedList: $list),
                    label: {
                        Text(list.text)
                    })
            }
            
          Section {
            Button(action: addReminderAction) {
              Text("Add Reminder")
            }
          }
        }
        .navigationBarTitle(Text("Yeni Animsatici"), displayMode: .inline)
      }
    }

    private func addReminderAction() {
      onComplete(
        title.isEmpty ? AddReminderPageView.DefaultReminderTitle : title,
        note.isEmpty ? AddReminderPageView.DefaultReminderNote : note,
        releaseDate,
        list.text.isEmpty ? AddReminderPageView.DefaultList : list)
    }
}

//struct AddReminderPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddReminderPageView()
//    }
//}
