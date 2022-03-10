//
//  gomiCalendarApp.swift
//  gomiCalendar
//
//  Created by 川崎　春菜 on 2022/03/04.
//
//

import SwiftUI

@main
struct gomiCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DisplayState())
                .environmentObject(GarbageCollectionSettingModalState())
                .environmentObject(RegionSettingModalState())
        }
    }
}
