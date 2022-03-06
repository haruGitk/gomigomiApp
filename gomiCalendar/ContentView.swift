//
//  ContentView.swift
//  gomiCalendar
//
//  Created by 川崎　春菜 on 2022/03/04.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button(action: {read_db()}){
            Text("read db")
        }
    }
    
    // https://note.com/dngri/n/ndd5af885162e
    func read_db(){
        
        print("front read_db")
        let db = Firestore.firestore()
        
        var pref = "東京都"
        var minici = "千代田区"
        var area = "西神田"
        var chome = "２丁目"
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("gomi_list").getDocument{(querysnapshot, error) in
            if let error = error {
                print("\(error)")
                return
            }
            guard let data = querysnapshot?.data() else {return}
            print(data)
            
            
        }
        print("back read_db")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
