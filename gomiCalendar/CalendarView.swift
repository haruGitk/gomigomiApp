//
//  CalendarView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/05.
//
//

import SwiftUI
import Foundation

struct CalendarView: View {
    @EnvironmentObject var showingRegionSettingModal: RegionSettingModalState
    @EnvironmentObject var showingGarbageCollectionSettingModal: GarbageCollectionSettingModalState
    @State private var date = Date()
    var pref = "東京都"
    var city = "調布市"
    var area = "下石原"
    
    // データベース受け渡し用の変数
    let data: Dictionary<String, Dictionary<String,Int>> = [
        "可燃ゴミ": ["月曜日": 1],
        "不燃ゴミ": ["火曜日": 1],
        "プラスチック": ["水曜日": 1],
        "ビン": ["木曜日": 1],
        "カン": ["金曜日": 1],
        "古紙": ["月曜日": 1],
        "その他": ["火曜日": 1]
    ]
  
    var paperday = "月曜日"
    var burnableday = "火曜日"
    var plasticday = "水曜日"
    var unburnableday = "木曜日"
    var canday = "金曜日"
    var bottleday = "金曜日"
    var otherday = "月曜日"
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
                .padding(10)
                
                ZStack {
                    Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0)
                         .ignoresSafeArea()
                    HStack{
                        if paperday == date.formatted(.dateTime.weekday())+"曜日"{
                            Image("paper")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                        }
                        if burnableday == date.formatted(.dateTime.weekday())+"曜日"{
                            Image("burnable")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                        }
                        if plasticday == date.formatted(.dateTime.weekday())+"曜日"{
                            Image("plastic")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                        }
                        if unburnableday == date.formatted(.dateTime.weekday())+"曜日"{
                            Image("unburnable")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                        }
                        if canday == date.formatted(.dateTime.weekday())+"曜日"{
                            Image("can")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                        }
                        if bottleday == date.formatted(.dateTime.weekday())+"曜日"{
                            Image("bottle")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                        }
                        if otherday == date.formatted(.dateTime.weekday())+"曜日"{
                            Image("other")
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .clipShape(Circle())
                        }
                    }
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
