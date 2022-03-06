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
    
    // https://thwork.net/2020/11/13/%E3%80%90swiftui%E3%80%91%E4%B8%80%E7%95%AA%E7%B0%A1%E5%8D%98%E3%81%AAfirebase%E3%81%AE%E5%88%9D%E6%9C%9F%E5%8C%96%E6%96%B9%E6%B3%95/
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
