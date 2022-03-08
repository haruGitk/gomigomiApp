//
//  CalendarView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/05.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var showingRegionSettingModal: RegionSettingModalState
    @EnvironmentObject var showingGarbageCollectionSettingModal: GarbageCollectionSettingModalState
    @State private var date = Date()
    var pref = "東京都"
    var city = "調布市"
    var area = "下石原"
    var block = "1"
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing: 10) {
                HStack{
                    Text("ゴミカレンダー")
                        .font(.title)
                        .fontWeight(.bold)
                    Button(action: {showingGarbageCollectionSettingModal.showingModal = true}) {
                        Image("setting")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                HStack{
                    Text("地域: ")
                    Button(action: {showingRegionSettingModal.showingModal = true}) {
                        Text("\(pref)\(city)\(area)\(block)")
                            .font(.callout)
                    }
                }
            }
            VStack(spacing: 5) {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .frame(maxHeight: 300)
                ZStack {
                    Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1)
                         .ignoresSafeArea()
                         .padding()
                    Text(date, format: .dateTime.weekday())
                }
                .frame(height: 100)
            }
            
        }.sheet(isPresented: $showingGarbageCollectionSettingModal.showingModal) {
            GarbageSettingModalView(showingModal: showingGarbageCollectionSettingModal.showingModal)
        }
        .sheet(isPresented: $showingRegionSettingModal.showingModal) {
            ModalView(showingModal: showingRegionSettingModal.showingModal)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

class GarbageCollectionSettingModalState: ObservableObject {
    @Published var showingModal: Bool = false
}

class RegionSettingModalState: ObservableObject {
    @Published var showingModal: Bool = false
}
