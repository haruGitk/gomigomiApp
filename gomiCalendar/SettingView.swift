//
//  RegionSettingView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/04.
//

import SwiftUI

struct RegionSettingView: View {
    @State private var showingModal = false
    
    var body: some View {
        Button(action: {
            self.showingModal.toggle()
        }) {
            Text("地域を\n設定する")
                .font(.callout)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .frame(width: 100, height: 100)
                .background(Color.green)
                .clipShape(Circle())
        }.sheet(isPresented: $showingModal) {
            ModalView(showingModal: showingModal)
        }
    }
}

struct RegionSettingView_Previews: PreviewProvider {
    static var previews: some View {
        RegionSettingView()
    }
}

struct ModalView: View {
    @AppStorage("regionRegistered") var regionRegistered = false
    @EnvironmentObject private var displayState: DisplayState
    @EnvironmentObject var showingRegionSettingModal: RegionSettingModalState
    @State var postalCode: String = ""
    @State var pref: String = "東京都"
    @State var city: String = ""
    @State var area: String = ""
    @State var block: String = ""
    @State var showingModal: Bool
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                List {
                    HStack(spacing: 20) {
                        TextField("郵便番号（半角）", text: $postalCode)
                            .border(Color.gray, width: 2)
                            .cornerRadius(3.0)
                        Button(action: {print(postalCode)}) {
                            Text("自動入力")
                        }
                    }
                    Picker(selection: $pref, label: Text("都道府県")) {
                        ForEach(prefecturesData) {
                            prefecture in
                            Text(prefecture.name).tag(prefecture.name)
                        }
                    }
                    .clipped()
                    TextField("市区町村（全角）", text: $city)
                        .border(Color.gray, width: 2)
                        .cornerRadius(3.0)
                        .disableAutocorrection(true)
                    TextField("地区（全角）", text: $area)
                        .border(Color.gray, width: 2)
                        .cornerRadius(3.0)
                        .disableAutocorrection(true)
                    TextField("丁目（半角数字）", text: $block)
                        .border(Color.gray, width: 2)
                        .cornerRadius(3.0)
                        .disableAutocorrection(true)
                }
                .padding(20)
                .textFieldStyle(.roundedBorder)
                Button(action: {
                    var data: Dictionary<String, Dictionary<String, String>> = [
                        "region": [
                            "pref": pref,
                            "city": city,
                            "area": area,
                            "block": block
                        ]
                    ]
                    if (displayState.displayMode == display.regionSetting) {
                        displayState.displayMode = display.calendar
                    } else {
                        showingRegionSettingModal.showingModal = false
                    }
                    regionRegistered = true
                })
                    {
                    Text("設定する")
                        .font(.footnote)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 70, height: 70)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            .navigationTitle("地域設定").navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func getRegionalGarbageCollectionInformation() {
        @State var results = [Result]()   // 空の書籍情報配列を生成
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=swiftui&country=jp&media=ebook") else {
            /// 文字列が有効なURLでない場合の処理
            return
        }
        // リクエストの作成
        let request = URLRequest(url: url)
        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {    // ①データ取得チェック
                /// ②JSON→Responseオブジェクト変換
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode(Response.self, from: data) else {
                    print("Json decode エラー")
                    return
                }
 
                /// ③書籍情報をUIに適用
                DispatchQueue.main.async {
                    results = decodedResponse.results
                }
                print(decodedResponse)
 
            } else {
 
                /// ④データが取得できなかった場合の処理
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
            
        }.resume()
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(showingModal: true)
    }
}

/// APIから取得する戻り値の型
struct Response: Codable {
    var results: [Result]
}
 
/// 個々の書籍情報の型
struct Result: Codable {
    var trackId: Int                // 書籍データのID
    var trackName: String?          // 書籍タイトル
    var artistName: String?         // 著者名
    var formattedPrice: String?     // 価格（テキスト形式）
}
