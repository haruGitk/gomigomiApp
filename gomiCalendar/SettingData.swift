//
//  SettingData.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/04.
//

import SwiftUI

let prefecturesData = [
    PrefectureData(name:"北海道"),
    PrefectureData(name:"青森県"),
    PrefectureData(name:"岩手県"),
    PrefectureData(name:"宮城県"),
    PrefectureData(name:"秋田県"),
    PrefectureData(name:"山形県"),
    PrefectureData(name:"福島県"),
    PrefectureData(name:"茨城県"),
    PrefectureData(name:"栃木県"),
    PrefectureData(name:"群馬県"),
    PrefectureData(name:"埼玉県"),
    PrefectureData(name:"千葉県"),
    PrefectureData(name:"東京都"),
    PrefectureData(name:"神奈川県"),
    PrefectureData(name:"新潟県"),
    PrefectureData(name:"富山県"),
    PrefectureData(name:"石川県"),
    PrefectureData(name:"福井県"),
    PrefectureData(name:"山梨県"),
    PrefectureData(name:"長野県"),
    PrefectureData(name:"岐阜県"),
    PrefectureData(name:"静岡県"),
    PrefectureData(name:"愛知県"),
    PrefectureData(name:"三重県"),
    PrefectureData(name:"滋賀県"),
    PrefectureData(name:"京都府"),
    PrefectureData(name:"大阪府"),
    PrefectureData(name:"兵庫県"),
    PrefectureData(name:"奈良県"),
    PrefectureData(name:"和歌山県"),
    PrefectureData(name:"鳥取県"),
    PrefectureData(name:"島根県"),
    PrefectureData(name:"岡山県"),
    PrefectureData(name:"広島県"),
    PrefectureData(name:"山口県"),
    PrefectureData(name:"徳島県"),
    PrefectureData(name:"香川県"),
    PrefectureData(name:"愛媛県"),
    PrefectureData(name:"高知県"),
    PrefectureData(name:"福岡県"),
    PrefectureData(name:"佐賀県"),
    PrefectureData(name:"長崎県"),
    PrefectureData(name:"熊本県"),
    PrefectureData(name:"大分県"),
    PrefectureData(name:"宮崎県"),
    PrefectureData(name:"鹿児島県"),
    PrefectureData(name:"沖縄県"),
]

struct PrefectureData: Identifiable {
    var id = UUID()
    var name: String
}
