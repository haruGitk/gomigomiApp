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
    
    // 地域設定用変数 - 永続化
    @AppStorage("pref") var pref: String = "東京都"
    @AppStorage("city") var city: String = ""
    @AppStorage("area") var area: String = ""
    @AppStorage("block") var block: String = ""
    
    // ごみ回収日用変数 - 永続化
    @AppStorage("burnableDay") var burnableday: String = ""
    @AppStorage("unburnableDay") var unburnableday: String = ""
    @AppStorage("paperDay") var paperday: String = ""
    @AppStorage("canDay") var canday: String = ""
    @AppStorage("plasticDay") var plasticday: String = ""
    @AppStorage("bottleDay") var bottleday: String = ""
    @AppStorage("othersDay") var othersday: String = ""
    
    
    func format(day:Date)->Int{
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd"
            let strDate = dateformatter.string(from: day)
            let numDate = Int(strDate)
            return numDate!
       
    }
    
    func nextWeekDay(week:String)->String{
        let weekArray = ["日", "月", "火", "水", "木", "金", "土"]
        var index = 0
        for i in 0..<weekArray.count {
            if week == weekArray[i]{
                index = i
            }
        }
        return weekArray[(index+1)%7]
    }
    
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
                        if ("\(pref)\(city)\(area)\(block)" == "") {
                            Text("地域を選択してください")
                        } else {
                            Text("\(pref)\(city)\(area)\(block)")
                                .font(.callout)
                        }
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
                    HStack(alignment: .bottom){
                        Spacer()
                        Spacer().frame(width: 10)
                        VStack(alignment: .leading){
                            Text(date.formatted(.dateTime.day()))
                                .font(.title)
                                .foregroundColor(Color.red)
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
                                if othersday == date.formatted(.dateTime.weekday())+"曜日"{
                                    Image("other")
                                    .resizable()
                                    .frame(width: 80.0, height: 80.0)
                                    .clipShape(Circle())
                                }
                            }
                        }
                        Spacer().frame(width: 10)
                        Divider()
                        //次の日
                        Spacer()
                        VStack(alignment: .leading){
                            Text("\(format(day: date)+1)"+"日")
                                .foregroundColor(Color.blue)
                            HStack{
                                if paperday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
                                    Image("paper")
                                    .resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .clipShape(Circle())
                                }
                                if burnableday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
                                    Image("burnable")
                                    .resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .clipShape(Circle())
                                }
                                if plasticday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
                                    Image("plastic")
                                    .resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .clipShape(Circle())
                                }
                                if unburnableday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
                                    Image("unburnable")
                                    .resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .clipShape(Circle())
                                }
                                if canday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
                                    Image("can")
                                    .resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .clipShape(Circle())
                                }
                                if bottleday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
                                    Image("bottle")
                                    .resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .clipShape(Circle())
                                }
                                if othersday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
                                    Image("other")
                                    .resizable()
                                    .frame(width: 60.0, height: 60.0)
                                    .clipShape(Circle())
                                }
                            }
                        }
                        Spacer().frame(width: 10)
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
