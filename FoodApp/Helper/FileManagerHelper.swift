//
//  FileManagerHelper.swift
//  FoodApp
//
//  Created by Mac on 15.12.24.
//

import Foundation

class FileManagerHelper {
    
    func getFilePath() -> URL {
        let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = file[0].appendingPathComponent("Foods.json")
        print(path)
        return path
    }
    
    func writeBasketData(basket: [Foods]) {
        do {
            let data = try JSONEncoder().encode(basket)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readData(completion: (([Foods]) -> Void)) {
        if let data = try? Data(contentsOf: getFilePath()) {
            do {
                let basket = try JSONDecoder().decode([Foods].self, from: data)
                completion(basket)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
