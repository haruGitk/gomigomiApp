//
//  ContentView.swift
//  gomiCalendar
//
//  Created by 川崎　春菜 on 2022/03/04.
//

import SwiftUI

enum display {
    case setting
    case calendar
}

struct ContentView: View {
    @EnvironmentObject private var displayState: DisplayState
    var body: some View {
        if displayState.displayMode == display.setting {
            SettingView()
        } else if displayState.displayMode == display.calendar {
            CalendarView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class DisplayState: ObservableObject {
    @Published var displayMode: display = display.setting
}
