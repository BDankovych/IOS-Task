//
//  UserDefaults.swift
//  Technical-test
//
//  Created by Користувач on 15.06.2023.
//

import Foundation

@propertyWrapper
class UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults
    
    init(key: String, defaultValue: Value, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }

    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
