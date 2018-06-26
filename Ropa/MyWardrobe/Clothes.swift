//
//  Clothes.swift
//  Ropa
//
//  Created by Chen Hsin on 2018/6/24.
//  Copyright © 2018年 Chen Hsin. All rights reserved.
//

import Foundation

struct Clothes {
    let id: String
    let date: String
    let price: Int
    let brand: String
    let color: String
    
    init(id: String, date: String, price: Int, brand: String, color: String) {
        self.id = id
        self.date = date
        self.price = price
        self.brand = brand
        self.color = color
    }
}
