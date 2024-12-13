//
//  UserDefaultsManager.swift
//  FoodApp
//
//  Created by Mac on 07.12.24.
//

import Foundation

class UserDefaultsManager {
    enum UserDefaultsTypes: String {
        case isLoggedIn = "isLoggedIn"
        case email = "email"
        case isRegistered = "isRegistered"
    }
    
    func setValue(value: Any, key: UserDefaultsTypes) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getBool(key: UserDefaultsTypes) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func getString(key: UserDefaultsTypes) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
}
