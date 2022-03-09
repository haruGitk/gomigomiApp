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
    @AppStorage("postalCode") var postalCode: String = ""
    @AppStorage("pref") var pref: String = "東京都"
    @AppStorage("city") var city: String = ""
    @AppStorage("area") var area: String = ""
    @AppStorage("block") var block: String = ""
    @State var results = [Result]()
    @State var showingModal: Bool
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack(spacing: 20) {
                        TextField("郵便番号（半角）", text: $postalCode)
                            .border(Color.gray, width: 2)
                            .cornerRadius(3.0)
                        Button(action: {
                            getRegionalGarbageCollectionInformation(postalCode: postalCode)
                        }) {
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
                .frame(height: 300)
                .padding()
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
    
    func getRegionalGarbageCollectionInformation(postalCode: String) {
        let endpoint = "https://zipcloud.ibsnet.co.jp/api/search"
        let query = "?zipcode=\(postalCode)"
        /// URLの生成
        guard let url = URL(string: endpoint + query) else {
            /// 文字列が有効なURLでない場合の処理
            return
        }
        /// URLリクエストの生成
        let request = URLRequest(url: url)
        
        /// URLにアクセス
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {   // ①データ取得チェック
 
                /// ②JSON→Responseオブジェクト変換
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode(Response.self, from: data) else {
                    pref = ""
                    city = ""
                    area = ""
                    block = ""
                    return
                }
                /// ③書籍情報をUIに適用
                DispatchQueue.main.async {
                    results = decodedResponse.results
                    pref = results[0].address1
                    city = results[0].address2
                    area = results[0].address3
                    block = ""
                }
 
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
    var address1: String  // 都道府県
    var address2: String  // 市区町村
    var address3: String  // 地域名
    var prefcode: String    // 都道府県コード
    var zipcode: String       // 郵便番号
}
