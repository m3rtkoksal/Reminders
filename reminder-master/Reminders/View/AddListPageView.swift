//
//  AddListPageView.swift
//  Reminders
//
//  Created by Mert Köksal on 26.04.2021.
//

import SwiftUI

struct AddListPageView: View {
    @State var selection: String = "swatch_shipcove"
    static let DefaultListTitle = "An untitled reminder"
    static let DefaultListImage = "Genre-buster"
    static let DefaultReminders = [Reminder]()
    @Binding var text: String
    @Binding var reminders : [Reminder]
    let onListComplete: (String, String, [Reminder] ) -> Void
    var body: some View {
        NavigationView {
            VStack{
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .fill(Color(selection))
                    .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 10 )
                    .padding()
                TitleBar(title: $text)
                ColorSwatchView(selection: $selection)
            }
            .navigationBarTitle(Text("Yeni Liste"), displayMode: .inline)
            .navigationBarColor(backgroundColor: .white, titleColor: .black)
            .navigationBarItems(
                leading:
                    NavigationCancelItem(),
                trailing:
                    Button(action: {
                        print("done button tapped")
                        addListAction()
                    }, label: {
                        Text("Bitti")
                            .foregroundColor(.blue)
                            .font(.system(size: 16, weight: .light, design: .rounded))
                    })
            )
        }
    }
    private func addListAction() {
      onListComplete(
        selection.isEmpty ? AddListPageView.DefaultListImage : selection,
        text.isEmpty ? AddListPageView.DefaultListTitle : text,
        reminders.isEmpty ? AddListPageView.DefaultReminders: [Reminder]())
    }
}

struct NavigationCancelItem: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Vazgec")
                .foregroundColor(.blue)
                .font(.system(size: 16, weight: .light, design: .rounded))
        })
    }
}

//struct AddListPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddListPageView( text: .constant(""))
//    }
//}
