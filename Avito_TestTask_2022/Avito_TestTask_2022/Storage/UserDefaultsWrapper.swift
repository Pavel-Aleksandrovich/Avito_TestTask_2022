//
//  UserDefaultsWrapper.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 13.11.2022.
//

import Foundation

protocol IUserDefaultsWrapper: AnyObject {
    func set<T: Codable>(value: T?, forKey: UserDefaultsKey)
    func removeObject(forKey: UserDefaultsKey)
    func isSaved(forKey: UserDefaultsKey) -> Bool
    func object(forKey: UserDefaultsKey) -> Any?
    func data(forKey: UserDefaultsKey) -> Data?
}

final class UserDefaultsWrapper {
    
    private let userDefaults = UserDefaults.standard
}

extension UserDefaultsWrapper: IUserDefaultsWrapper {
    
    func set<T: Codable>(value: T?, forKey: UserDefaultsKey) {
        userDefaults.set(value, forKey: forKey.rawValue)
    }
    
    func removeObject(forKey: UserDefaultsKey) {
        userDefaults.removeObject(forKey: forKey.rawValue)
    }
    
    func object(forKey: UserDefaultsKey) -> Any? {
        userDefaults.object(forKey: forKey.rawValue)
    }
    
    func data(forKey: UserDefaultsKey) -> Data? {
        userDefaults.data(forKey: forKey.rawValue)
    }
    
    func isSaved(forKey: UserDefaultsKey) -> Bool {
        userDefaults.object(forKey: forKey.rawValue) != nil
    }
}
