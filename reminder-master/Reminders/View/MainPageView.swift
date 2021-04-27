//
//  MainPageView.swift
//  Reminders
//
//  Created by Mert Köksal on 20.04.2021.
//

import SwiftUI

struct MainPageView: View {
    @State private var searchText = ""
    @Binding var lists : [ListModel]
    @Binding var reminders : [Reminder]
    @Binding var selectedList : ListModel
    var body: some View {
        ZStack {
            Color(.gray)
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                ZStack {
                    Color(.systemGray5)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        SearchBar(text: $searchText)
                        HStack(spacing: 20){
                            Today()
                            Timed()
                        }
                        .padding(.top,20)
                        All()
                            .padding(.top,7)
                        MyList(reminders: $reminders, lists: $lists, selectedList: selectedList)
                        Spacer()
                    }
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarColor(backgroundColor: .systemGray5, titleColor: .white)
                    .navigationBarItems(
                        trailing: HStack {
                            NavigationEditItem()
                        }
                    )
                }
            }
        }
    }
}

struct NavigationEditItem: View {
    @State var searchTap: Bool = false
    var body: some View {
        Button(action: {
            print("search button tapped")
            self.searchTap = true
        }, label: {
            Text("Duzenle")
                .foregroundColor(.blue)
        })
        NavigationLink("", destination: EditPageView(), isActive: $searchTap)
    }
}

struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    var titleColor: UIColor?
    
    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    
    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
    
}

struct Today: View {
    var body: some View {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day!
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
            HStack(alignment: .top, spacing: 100) {
                VStack(alignment: .leading){
                    ZStack{
                        Circle()
                            .foregroundColor(.blue)
                        Text(String(dayOfMonth))
                            .foregroundColor(.white)
                    }
                    .frame(width: 40, height: 40, alignment: .center)
                    Text("Bugun")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                }
                Text("0")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 80, alignment: .center)
    }
}

struct Timed: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
            HStack(alignment: .top, spacing: 45) {
                VStack(alignment: .leading){
                    Image(systemName: "calendar.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.red)
                    
                    Text("Zamanlanmis")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                }
                Text("0")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 80, alignment: .center)
    }
}

struct All: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
            HStack(alignment: .top) {
                VStack(alignment: .leading){
                    Image(systemName: "tray.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.gray)
                    
                    Text("Tumu")
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("0")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
            }
            .padding(.horizontal)
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 80, alignment: .center)
    }
}

struct MyList: View {
    @State var isAddReminder = false
    @State var isAddList = false
    @Binding var reminders : [Reminder]
    @Binding var lists : [ListModel]
    @State var isListSelected = false
    @State var selectedList : ListModel
    @State private var listTitleText = ""
    var body: some View {
        VStack{
            HStack {
                Text("Listelerim")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.leading)
            Form {
                ForEach(lists, id: \.text) { list in
                    Button(action: {
                        self.selectedList = list
                        print(selectedList)
                        self.isListSelected.toggle()
                    }) {
                        ListCell(list: list)
                    }
                }
                .onDelete(perform: deleteList)
            }
            .fullScreenCover(isPresented: $isListSelected) {
                ListDetailView(list: $selectedList)
            }
            .listStyle(PlainListStyle())
            .padding(.top, -10)
            .colorMultiply(Color(.systemGray6))
            Spacer()
            HStack{
                Button(action: {
                    self.isAddReminder.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                    Text("Yeni Animsatici")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                })
                .sheet(isPresented: $isAddReminder) {
                    AddReminderPageView(lists: $lists) { title, notes, date, list in
                        self.addReminder(title: title, notes: notes, date: date, list: list)
                        self.isAddReminder = false
                    }
                }
                Spacer()
                Button(action: {
                    self.isAddList.toggle()
                }, label: {
                    Text("Yeni Liste")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                })
               
                .sheet(isPresented: $isAddList){
                    AddListPageView(text: $listTitleText, reminders: $reminders) { color, text, reminders in
                        self.addList(color: color, text: text, reminders: reminders)
                        self.isAddList = false
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    func addReminder(title: String, notes: String, date: Date, list: ListModel) {
        let newReminder = Reminder(title: title, notes: notes, date: date, list: list)
        print(newReminder)
        reminders.append(newReminder)
    }
    func addList(color: String, text: String, reminders: [Reminder]) {
        let newList = ListModel(color: color, text: text, reminders: reminders)
        lists.append(newList)
    }
    
    func deleteList(at offsets: IndexSet) {
      lists.remove(atOffsets: offsets)
    }
}

//struct MainPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainPageView(lists: .constant([ListModel(color: "swatch_japonica", text: "2", reminders: [Reminder(title: "", notes: "", date: Date(timeIntervalSince1970: 1056730041), list: ListModel(color: "swatch_japonica", text: "3", reminders: [Reminder(title: "", notes: "", date: Date(timeIntervalSince1970: 1056730041), list: ListModel(color: "swatch_japonica", text: "4", reminders: [Reminder]()))]))])]))
//    }
//}
