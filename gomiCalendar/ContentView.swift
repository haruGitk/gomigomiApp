//
//  ContentView.swift
//  gomiCalendar
//
//  Created by 川崎　春菜 on 2022/03/04.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    let dbc1 = DataBaseClass()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button(action: {dbc1.readDataBase(pref: "東京都", minici: "千代田区", area: "西神田", chome: "３丁目", gomi_type: "可燃ゴミ")}){
            Text("read db")
        }
        Button(action: {dbc1.testReadDatabase()}){
            Text("test read db")
        }
        Button(action: {testWriteDb()}){
            Text("test write db")
        }
        Button(action: {check_returnValue_func()}){
            Text("search db")
        }
        Button(action: {testSearchDb()}){
            Text("test search db")
        }
    }
    
    func check_returnValue_func(){
        let result = dbc1.searchDataBase(pref: "千葉県", minici: "横須賀市", area: "久里浜", chome: "３丁目")
        
        print("result: ", result)
        print("in check func: ", dbc1.returnValue)
    }
    
    func testWriteDb(){
        print("start test_write_db")
        let db = Firestore.firestore()
        
        let pref = "神奈川県"
        let minici = "横須賀市"
        let area = "久里浜"
        let chome = "３丁目"
        let arrayData = ["Tuesday": 1, "Friday": 1]
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("不燃ゴミ").setData(arrayData){
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
        
        let pref = "山梨県"
        let minici = "甲府市"
        let area = "朝日"
        let chome = "１丁目"
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("可燃ゴミ").getDocument{(snap, error) in
            let data = snap?.data()
            if (data != nil){
                print("Document exist")
                print(data)
                
            } else{
                print(data)
                print("Document does not exist")
            }
        }
        print("end test_search_db")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
