//
//  CalendarView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/05.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var displayState: DisplayState
    var body: some View {
        VStack{
            Button(action: {displayState.displayMode = display.gabargeSetting}) {
                Text("ゴミカレンダーの登録")
            }
            Button(action: {displayState.displayMode = display.regionSetting}) {
                Text("地域の再設定")
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
