//
//  ContentView.swift
//  gomiCalendar
//
//  Created by 川崎　春菜 on 2022/03/04.
///

import SwiftUI
import Firebase

enum display {
    case regionSetting
    case gabargeSetting
    case calendar
}

struct ContentView: View {
    @AppStorage("regionRegistered") var regionRegistered = false
    @EnvironmentObject private var displayState: DisplayState
    let dbc1 = DataBaseClass()
    @State var value = 0
    var isDbTest = false
    
    var body: some View {
        if isDbTest {
            Text("Hello, world!")
                .padding()
            Button(action: {dbc1.readDataBase(pref: "東京都", city: "千代田区", area: "西神田", block: "２丁目", gomi_type: "可燃ゴミ")}){
                Text("read db")
            }
            Button(action: {dbc1.testReadDatabase()}){
                Text("test read db")
            }
            Button(action: {testWriteDb()}){
                Text("test write db")
            }
            Button(action: {testSearchDb()}){
                Text("test search db")
            }
            Button(action: {
                var emptyDict: Dictionary<String, Dictionary<String, String>> = [:]
                dbc1.checkData(pref: "静岡県", city: "千代田区", area: "西神田", block: "２丁目", setData: false, garbageCollectionData:emptyDict, completion: {(garbageCollectionData: Dictionary<String, Any>) -> () in print(garbageCollectionData)})
            }){
                Text("check db")
            }
        } else if regionRegistered {
            CalendarView()
        } else {
            RegionSettingView()
        }
    }
    
    func testWriteDb(){
        print("start test_write_db")
        let db = Firestore.firestore()
        
        let pref = "神奈川県"
        let city = "横須賀市"
        let area = "久里浜"
        let block = "３丁目"
        let arrayData = ["Tuesday": 1, "Friday": 1]
        
        db.collection("base").document("\(pref)").collection("\(city)").document("\(area)").collection("\(block)").document("不燃ゴミ").setData(arrayData){
            err in
            if let err = err{
                print("Error writing document: \(err)")
            } else{
                print("Document written")
            }
        }
        print("end test_write_db")
    }
    
    func testSearchDb(){
        print("start test_search_db")
        let db = Firestore.firestore()
        
        let pref = "東京都"
        let city = "千代田区"
        let area = "西神田"
        let block = "２丁目"
        
        db.collection("base").document("\(pref)").collection("\(city)").document("\(area)").collection("\(block)").document("可燃ゴミ").getDocument{(snap, error) in
            
            print("after db in")
            if let error = error{
                print("\(error)")
                return
            }
            guard let data = snap?.data()else{
                print("Doc does not exist")
                return
            }
            
            print(data)
            //            if (data != nil){
            //                print("Document exist")
            //                print(data)
            //
            //            } else{
            //                print(data)
            //                print("Document does not exist")
            //            }
        }
        print("end test_search_db")
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
