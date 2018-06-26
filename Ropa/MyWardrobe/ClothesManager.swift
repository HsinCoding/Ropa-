//
//  ClothesManager.swift
//  Ropa
//
//  Created by Chen Hsin on 2018/6/25.
//  Copyright © 2018年 Chen Hsin. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ClothesManager {
    var ref: DatabaseReference?
    weak var delegate: ClotheseManagerDelegate?
    func getClothes() {
        var clothing: [Clothes] = []
        ref = Database.database().reference()
        ref?.child("clothes").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            for key in dictionary.keys {
                if let brand = dictionary["brand"] as? String {
                    if let color = dictionary["color"] as? String {
                        if let date = dictionary["date"] as? String {
                            if let price = dictionary["price"] as? Int {
                                let clothes = Clothes.init(id: key, date: date, price: price, brand: brand, color: color)
                                clothing.append(clothes)
                            }
                            else {
                                //error handing
                                print("The price can't wrap into Int")
                            }
                        }
                        else {
                            //error handing
                            print("The date can't wrap into String")
                        }
                    }
                    else {
                        //error handing
                        print("The color can't wrap into String")
                    }
                }
                else {
                    //error handing
                    print("The brand can't wrap into String")
                }
            }
            
            
        })
        
        
        
        
        
        
    }
}

