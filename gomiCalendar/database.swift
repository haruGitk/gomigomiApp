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
        let city = "千代田区"
        let area = "西神田"
        let block = "２丁目"
        
        db.collection("base").document("\(pref)").collection("\(city)").document("\(area)").collection("\(block)").document("可燃ゴミ").getDocument{(querysnapshot, error) in
            if let error = error {
                print("\(error)")
                return
            }
            guard let data = querysnapshot?.data() else {return}
            print(data)
        }
        print("back test_read_db")
    }
    
    func readDataBase(pref: String, city: String, area: String, block: String, gomi_type: String){
        print("start read_db")
        
        let db = Firestore.firestore()
        
        db.collection("base").document("\(pref)").collection("\(city)").document("\(area)").collection("\(block)").document("\(gomi_type)").getDocument{(snapshot, error) in
            if let error = error {
                print("\(error)")
                return
            }
            guard let data = snapshot?.data() else {
                print("test")
                return
            }
            print(data)
        }
        print("end read_db")
    }
    
    func writeDataBase(pref: String, city: String, area: String, block: String, gomi_type: String, day: String, week: Int){
        print("start write_db")
        
        let db = Firestore.firestore()
        
        db.collection("base").document("\(pref)").collection("\(city)").document("\(area)").collection("\(block)").document("\(gomi_type)").setData(["\(day)": week]){
            err in
            if let err = err{
                print("Error writing document: \(err)")
            } else{
                print("Document written")
            }
        }
        print("end write_db")
    }
    
    var garbageCollectionData: Dictionary<String, Any> = [
        "burnableday": ["":""],
        "unburnableday": ["":""],
        "paperday" : ["":""],
        "canday": ["":""],
        "plasticday": ["":""],
        "bottleday": ["":""],
        "othersday": ["":""],
        "hasData": false
    ]
    
    func checkData(pref: String, city: String, area: String, block: String, setData: Bool, garbageCollectionData: Dictionary<String, Dictionary<String, String>>, completion: @escaping (Dictionary<String, Any>)->()) {
        let db = Firestore.firestore()
        db.collection("base").document("\(pref)").collection("\(city)").document("\(area)").collection("\(block)").getDocuments{(snapshot, error) in
            if let error = error{
                print("\(error)")
                return
            }
            guard let data = snapshot?.documents else{
                print("document")
                return
            }
            if  setData {
                print("data empty")
                for (kind, data) in garbageCollectionData {
                    db.collection("base").document("\(pref)").collection("\(city)").document("\(area)").collection("\(block)").document("\(kind)").setData(data)
                }
            } else if data == [] {
            }
            else {
                self.garbageCollectionData["hasData"] = true
                for document in data {
                    switch document.documentID {
                        case "可燃ゴミ":
                        print("可燃ゴミ: \(document.data())")
                        self.garbageCollectionData["burnableday"] = document.data()
                        case "不燃ゴミ":
                        print("不燃ゴミ: \(document.data())")
                        self.garbageCollectionData["unburnableday"] = document.data()
                        case "古紙":
                        print("古紙: \(document.data())")
                        self.garbageCollectionData["paperday"] = document.data()
                        case "カン":
                        print("カン: \(document.data())")
                        self.garbageCollectionData["canday"] = document.data()
                        case "プラスチック":
                        print("プラ: \(document.data())")
                        self.garbageCollectionData["plasticday"] = document.data()
                        case "ビン":
                        print("ビン: \(document.data())")
                        self.garbageCollectionData["bottleday"] = document.data()
                        case "その他":
                        print("その他: \(document.data())")
                        self.garbageCollectionData["othersday"] = document.data()
                        default:
                        print("unexpected data type")
                    }
                }
                completion(self.garbageCollectionData)
            }
        }
    }
}
