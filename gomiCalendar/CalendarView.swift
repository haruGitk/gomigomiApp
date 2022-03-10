//
//  CalendarView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/05.
//
//

import SwiftUI
import Foundation

// データベース受け渡し用の変数
var datasample: Dictionary<String, Dictionary<String,Int>> = [
    "可燃ゴミ": ["月曜日": 1],
    "不燃ゴミ": ["火曜日": 1],
    "プラスチック": ["水曜日": 1],
    "ビン": ["木曜日": 1],
    "カン": ["金曜日": 1],
    "古紙": ["月曜日": 1],
    "その他": ["火曜日": 1]
]

struct CalendarView: View {
    @EnvironmentObject var showingRegionSettingModal: RegionSettingModalState
    @EnvironmentObject var showingGarbageCollectionSettingModal: GarbageCollectionSettingModalState
    @State private var date = Date()
    @AppStorage("pref") var pref: String = "東京都"
    @AppStorage("city") var city: String = ""
    @AppStorage("area") var area: String = ""
    @AppStorage("block") var block: String = ""
    

  
    var paperday = (datasample["古紙"]?.keys.first!)!
    var burnableday = (datasample["可燃ゴミ"]?.keys.first!)!
    var plasticday = (datasample["プラスチック"]?.keys.first!)!
    var unburnableday = (datasample["不燃ゴミ"]?.keys.first!)!
    var canday = (datasample["カン"]?.keys.first!)!
    var bottleday = (datasample["ビン"]?.keys.first!)!
    var otherday = (datasample["その他"]?.keys.first!)!
    
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
                                if otherday == date.formatted(.dateTime.weekday())+"曜日"{
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
                                if otherday == nextWeekDay(week: date.formatted(.dateTime.weekday()))+"曜日"{
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
