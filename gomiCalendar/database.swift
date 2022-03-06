//
//  database.swift
//  gomiCalendar
//
//  Created by liuchenghui on 2022/03/05.
//

import UIKit
import Firebase

struct Area{
    var pref: String
    var minicipalities: String
    var area: String
    var chome: String
}

struct Rubbish{
    var day: String
    var type: String
}

class database: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let db = Firestore.firestore()
        
        var pref = "東京都"
        var minici = "千代田区"
        var area = "西神田"
        var chome = "１丁目"
        
        db.collection("base").document("\(pref)").getDocument{(querysnapshot, error) in
            if let error = error {
                print("\(error)")
                return
            }
            guard let data = querysnapshot?.data() else {return}
            print(data)
            
            
        }
        
//        var areas: [Area] = []
//
//        db.collection("base").getDocuments(){
//            collection, err in
//
//            if let err = err{
//                print("Error: getting documents: \(err)")
//            }else{
//                for document in collection!.documents{
//                    guard  let rubbishDicList: [[String: Any]] = document.get("gomi_list") as? [[String: Any]] else {
//                        continue
//                    }
//
//
//                    var rubbishtypes: [Rubbish] = []
//
//                    for rubbishDic in rubbishDicList {
//                        guard let rubbishDay = rubbishDic["day"] as? String, let rubbishType = rubbishDic["type"] as? String else{
//                            continue
//                        }
//
//                        let rubbish = Rubbish(day: rubbishDay, type: rubbishType)
//
//                        rubbishtypes.append(rubbish)
//
//                    }
//
//                    let area = Area()
//
//                }
//            }
//        }
    }
}
