//
//  Clothes.swift
//  Ropa
//
//  Created by Chen Hsin on 2018/6/24.
//  Copyright © 2018年 Chen Hsin. All rights reserved.
//

import Foundation

struct Clothes {

    let date: String
    let price: Int
    let brand: String
    let color: String
    
    init( date: String, price: Int, brand: String, color: String) {

        self.date = date
        self.price = price
        self.brand = brand
        self.color = color
    }
}
