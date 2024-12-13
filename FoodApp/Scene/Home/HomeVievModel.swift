//
//  HomeVievModel.swift
//  FoodApp
//
//  Created by Mac on 11.12.24.
//

import Foundation

class HomeVievModel {
    var foodModel: [FoodCategory] = []
    
    func getUrl() {
        if let fileUrl = Bundle.main.url(forResource: "Foods", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                foodModel = try JSONDecoder().decode([FoodCategory].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
