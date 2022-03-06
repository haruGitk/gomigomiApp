//
//  database.swift
//  gomiCalendar
//
//  Created by liuchenghui on 2022/03/05.
//

import SwiftUI
import Firebase

class DataBaseClass{
    // https://note.com/dngri/n/ndd5af885162e
    func testReadDatabase(){
        
        print("front test_read_db")
        let db = Firestore.firestore()
        
        let pref = "東京都"
        let minici = "千代田区"
        let area = "西神田"
        let chome = "２丁目"
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("可燃ゴミ").getDocument{(querysnapshot, error) in
            if let error = error {
                print("\(error)")
                return
            }
            guard let data = querysnapshot?.data() else {return}
            print(data)
            
            
        }
        print("back test_read_db")
    }
    
    func readDataBase(pref: String, minici: String, area: String, chome: String, gomi_type: String){
        print("front read_db")
        
        let db = Firestore.firestore()
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("\(gomi_type)").getDocument{(snapshot, error) in
            if let error = error {
                print("\(error)")
                return
            }
            guard let data = snapshot?.data() else {return}
            print(data)
        }
    }
    
    func writeDataBase(pref: String, minici: String, area: String, chome: String, gomi_type: String){
        
    }
    
}
