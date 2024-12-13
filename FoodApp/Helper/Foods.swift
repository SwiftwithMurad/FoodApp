//
//  Foods.swift
//  FoodApp
//
//  Created by Mac on 07.12.24.
//

import Foundation

struct FoodCategory: Codable {
    let name: String?
    let image: String? 
    let category: [Foods]?
}

struct Foods: Codable {
    let name: String?
    let price: String?
    let currency: String?
    let image: String?
}

