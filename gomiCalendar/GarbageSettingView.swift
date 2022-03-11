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
    @AppStorage("pref") var pref: String = "東京都"
    @AppStorage("city") var city: String = ""
    @AppStorage("area") var area: String = ""
    @AppStorage("block") var block: String = ""
    // pickerが辞書型の変数を受け付けなかったため、一時的に個別の変数を導入
    @AppStorage("burnableDay") var burnableday: String = ""
    @AppStorage("unburnableDay") var unburnableday: String = ""
    @AppStorage("paperDay") var paperday: String = ""
    @AppStorage("canDay") var canday: String = ""
    @AppStorage("plasticDay") var plasticday: String = ""
    @AppStorage("bottleDay") var bottleday: String = ""
    @AppStorage("othersDay") var othersday: String = ""
    @State var showingModal: Bool
    var dbc1 = DataBaseClass()
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
                            Picker(selection: $burnableday, label: Text("可燃ゴミ")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.unburnable:
                            Picker(selection: $unburnableday, label: Text("不燃ゴミ")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.plastic:
                            Picker(selection: $plasticday, label: Text("プラスチック")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.bottle:
                            Picker(selection: $bottleday, label: Text("ビン")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.can:
                            Picker(selection: $canday, label: Text("カン")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.paper:
                            Picker(selection: $paperday,  label: Text("古紙")) {
                                ForEach(dayData) {
                                    day in
                                    daySelectionView(day: day).tag(day.name)
                                }
                            }
                        case garbage.others:
                            Picker(selection: $othersday, label: Text("その他")) {
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
                    var emptyDict: Dictionary<String, Dictionary<String, String>> = [:]
                    // データベース受け渡し用の変数
                    let data: Dictionary<String, Dictionary<String,String>> = [
                        "可燃ゴミ": [burnableday: "1"],
                        "不燃ゴミ": [unburnableday: "1"],
                        "プラスチック": [plasticday: "1"],
                        "ビン": [bottleday: "1"],
                        "カン": [canday: "1"],
                        "古紙": [paperday: "1"],
                        "その他": [othersday: "1"]
                    ]
                    dbc1.checkData(pref: pref, city: city, area: area, block: block, setData: true, garbageCollectionData: data, completion: {(garbageCollectionData: Dictionary<String, Any>) -> () in print(garbageCollectionData)})
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
