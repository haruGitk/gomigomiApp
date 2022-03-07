//
//  GarbageSettingView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/07.
//

import SwiftUI

struct GarbageSettingModalView: View {
    // ページ遷移用変数
    @EnvironmentObject private var displayState: DisplayState
    @EnvironmentObject var showingGarbageCollectionSettingModal: GarbageCollectionSettingModalState
    // pickerが辞書型の変数を受け付けなかったため、一時的に個別の変数を導入
    @State var burnable = ""
    @State var unburnable = ""
    @State var plastic = ""
    @State var bottle = ""
    @State var can = ""
    @State var paper = ""
    @State var others = ""
    @State var showingModal: Bool
    var garbageTypeData = [
        GarbageTypeData(garbage: garbage.burnable, name: "可燃ゴミ"),
        GarbageTypeData(garbage: garbage.unburnable, name: "不燃ゴミ"),
        GarbageTypeData(garbage: garbage.plastic, name: "プラスチック"),
        GarbageTypeData(garbage: garbage.bottle, name: "ビン"),
        GarbageTypeData(garbage: garbage.can, name: "カン"),
        GarbageTypeData(garbage: garbage.paper, name: "古紙"),
        GarbageTypeData(garbage: garbage.others, name: "その他"),
    ]
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                List{
                    ForEach(garbageTypeData) {
                        garbageType in
                        switch garbageType.garbage {
                        case garbage.burnable:
                            Picker(selection: $burnable, label: Text("可燃ゴミ")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.unburnable:
                            Picker(selection: $unburnable, label: Text("不燃ゴミ")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.plastic:
                            Picker(selection: $plastic, label: Text("プラスチック")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.bottle:
                            Picker(selection: $bottle, label: Text("ビン")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.can:
                            Picker(selection: $can, label: Text("カン")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.paper:
                            Picker(selection: $paper,  label: Text("古紙")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.others:
                            Picker(selection: $others, label: Text("その他")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        }
                    }
                }
                .frame(maxHeight: 380)
                .clipped()
                Button(action: {
                    // データベース受け渡し用の変数
                    let data: Dictionary<String, Dictionary<String,Int>> = [
                        "可燃ゴミ": [burnable: 1],
                        "不燃ゴミ": [unburnable: 1],
                        "プラスチック": [plastic: 1],
                        "ビン": [bottle: 1],
                        "カン": [can: 1],
                        "古紙": [paper: 1],
                        "その他": [others: 1]
                    ]
                    showingGarbageCollectionSettingModal.showingModal = false
                }) {
                    Text("完了")
                        .font(.callout)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .frame(width: 70, height: 70)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }.navigationTitle("ごみ収集日設定")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GarbageSettingModalView_Previews: PreviewProvider {
    static var previews: some View {
        GarbageSettingModalView(showingModal: true)
    }
}

struct DayData: Identifiable {
    var id = UUID()
    var day: day
    var name: String
}

var dayData = [
    DayData(day: day.sunday, name: "日曜日"),
    DayData(day: day.monday, name: "月曜日"),
    DayData(day: day.tuesday, name: "火曜日"),
    DayData(day: day.wednesday, name: "水曜日"),
    DayData(day: day.thursday, name: "木曜日"),
    DayData(day: day.friday, name: "金曜日"),
    DayData(day: day.saturday, name: "土曜日"),
]

struct GarbageTypeData: Identifiable {
    var id = UUID()
    var garbage: garbage
    var name: String
}

enum day {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

enum garbage {
    case burnable
    case unburnable
    case plastic
    case bottle
    case can
    case paper
    case others
}

struct daySelectionView: View {
    var day: DayData
    var body: some View {
        Text(day.name)
    }
}
