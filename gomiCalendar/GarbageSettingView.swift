//
//  GarbageSettingView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/07.
//

import SwiftUI

struct GarbageSettingView: View {
    var garbageCollectionData = [
        GarbageCollectionDay(day: day.sunday, garbage: garbage.initial),
        GarbageCollectionDay(day: day.monday, garbage: garbage.initial),
        GarbageCollectionDay(day: day.tuesday, garbage: garbage.initial),
        GarbageCollectionDay(day: day.wednesday, garbage: garbage.initial),
        GarbageCollectionDay(day: day.thursday, garbage: garbage.initial),
        GarbageCollectionDay(day: day.friday, garbage: garbage.initial),
        GarbageCollectionDay(day: day.saturday, garbage: garbage.initial),
    ]
    @State var data: String = ""
    
    var body: some View {
        NavigationView {
            List{
                ForEach(garbageCollectionData) {
                    garbageCollection in
                    switch garbageCollection.day {
                    case day.sunday:
                        Picker(selection: $data, label: Text("日曜日")) {
                            ForEach(garbageTypeData) {
                                garbageType in
                                garbageSelectionView(garbageType: garbageType)
                            }
                        }
                    case day.monday:
                        Text("月曜日")
                    case day.tuesday:
                        Text("火曜日")
                    case day.wednesday:
                        Text("水曜日")
                    case day.thursday:
                        Text("木曜日")
                    case day.friday:
                        Text("金曜日")
                    case day.saturday:
                        Text("土曜日")
                    }
                }
            }.navigationTitle("ごみ収集日設定")
        }
    }
}

struct GarbageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GarbageSettingView()
    }
}

struct GarbageCollectionDay: Identifiable {
    var id = UUID()
    var day: day
    var garbage: garbage
}

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
    case initial
}

var garbageTypeData = [
    GarbageTypeData(garbage: garbage.burnable, name: "燃えるゴミ"),
    GarbageTypeData(garbage: garbage.unburnable, name: "燃えないゴミ"),
    GarbageTypeData(garbage: garbage.plastic, name: "プラスチック"),
    GarbageTypeData(garbage: garbage.bottle, name: "ビン"),
    GarbageTypeData(garbage: garbage.can, name: "缶"),
    GarbageTypeData(garbage: garbage.paper, name: "古紙・段ボール"),
    GarbageTypeData(garbage: garbage.others, name: "その他"),
    GarbageTypeData(garbage: garbage.initial, name: ""),
]

struct garbageSelectionView: View {
    var garbageType: GarbageTypeData
    var body: some View {
        Text(garbageType.name)
    }
}
