//
//  ContentView.swift
//  gomiCalendar
//
//  Created by 川崎　春菜 on 2022/03/04.
//

import SwiftUI

enum display {
    case regionSetting
    case gabargeSetting
    case calendar
}

struct ContentView: View {
    @AppStorage("regionRegistered") var regionRegistered = false
    @EnvironmentObject private var displayState: DisplayState
    var body: some View {
        if regionRegistered {
            CalendarView()
        } else {
            RegionSettingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DisplayState())
    }
}

class DisplayState: ObservableObject {
    @Published var displayMode: display = display.regionSetting
}
