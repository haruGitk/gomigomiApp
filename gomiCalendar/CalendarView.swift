//
//  CalendarView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/05.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var showingRegionSettingModal: RegionSettingModalState
    @EnvironmentObject var showingGarbageCollectionSettingModal: GarbageCollectionSettingModalState
    var body: some View {
        VStack{
            Button(action: {showingGarbageCollectionSettingModal.showingModal = true}) {
                Text("ゴミカレンダーの登録")
            }
            Button(action: {showingRegionSettingModal.showingModal = true}) {
                Text("地域の再設定")
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
