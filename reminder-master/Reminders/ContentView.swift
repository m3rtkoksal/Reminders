//
//  ContentView.swift
//  Reminders
//
//  Created by Mert Köksal on 20.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State var lists = [ListModel]()
    @State var reminders = [Reminder]()
    @State var selectedList = ListModel(color: "", text: "", reminders: [])
    var body: some View {
        MainPageView(lists: $lists, reminders: $reminders, selectedList: $selectedList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
