//
//  gomiCalendarApp.swift
//  gomiCalendar
//
//  Created by 川崎　春菜 on 2022/03/04.
//
//

import SwiftUI
import Firebase

@main
struct gomiCalendarApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
