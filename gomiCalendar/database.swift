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
        print("start read_db")
        
        let db = Firestore.firestore()
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("\(gomi_type)").getDocument{(snapshot, error) in
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
    
    func writeDataBase(pref: String, minici: String, area: String, chome: String, gomi_type: String, day: String, week: Int){
        print("start write_db")
        
        let db = Firestore.firestore()
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("\(gomi_type)").setData(["\(day)": week]){
            err in
            if let err = err{
                print("Error writing document: \(err)")
            } else{
                print("Document written")
            }
        }
        print("end write_db")
    }
    
    var returnValue: Int = -1
    
    func searchDataBase(pref: String, minici: String, area: String, chome: String, completion: @escaping (Int)->()){
        print("start search_db")
        let db = Firestore.firestore()
        
        db.collection("base").document("\(pref)").collection("\(minici)").document("\(area)").collection("\(chome)").document("可燃ゴミ").getDocument{(snapshot, error) in
            print("after db in")
            if let error = error{
                print("\(error)")
                return
            }
            guard let data = snapshot?.data() else{
                print("Doc does not exist")
                self.returnValue = 0
                return
            }
            
//            if (data != nil){
//                print("doc found")
//                self.returnValue = 1
//            } else {
//                print("doc not found")
//                self.returnValue = 0
//            }
            print(data)
            self.returnValue = 1
            
            completion(self.returnValue)
        }
        print("end search_db")
    }
    
    func checkSearch(returnValue: Int)-> Int{
        if (returnValue == 0){
            print("returnValue is 0")
            return 0
        }else{
            print("returnValue is 1")
            return 1
        }
    }
    
    func searchRepeat(pref: String, minici: String, area: String, chome: String) -> Int {
        var result: Int
        
        //        while(returnValue == -1){
        //           result = searchDataBase(pref: pref, minici: minici, area: area, chome: chome)
        //            break
        //        }
        
        print("in searchRepeat func: ", returnValue)
        return returnValue
    }
}
