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
        Button(action: {dbc1.readDataBase(pref: "東京都", minici: "千代田区", area: "西神田", chome: "２丁目", gomi_type: "可燃ゴミ")}){
            Text("read db")
        }
        Button(action: {dbc1.testReadDatabase()}){
            Text("test read db")
        }
        Button(action: {testWriteDb()}){
            Text("write db")
        }
    }
    
    func testWriteDb(){
        print("start test_write_db")
        let db = Firestore.firestore()
        
        let pref = "東京都"
        let minici = "千代田区"
        let area = "内神田"
        let chome = "３丁目"
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("資源ゴミ").setData(["Friday": 1])
        
        print("end test_write_db")
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
