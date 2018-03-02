//
//  Character.swift
//  Westeros
//
//  Created by luis gomez alonso on 8/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import Foundation
import UIKit

final class Person {
    let name: String
    let house: House
    let image: UIImage
    private let _alias: String?
    
    var alias: String {
        return _alias ?? ""
        // Esto es lo mismo
        /*if let _alias = _alias {
            // Existe y esta en _alias
            return _alias
        } else {
            return ""
        }*/
    }
    
    init(name: String, alias: String? = nil, house: House, image: UIImage) {
        self.name = name
        _alias = alias
        self.house = house
        self.image = image
        
        house.add(person: self)
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

// MARK: - Proxies
extension Person {
    var proxyForEquatable: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparable: String {
        return fullName
    }
}

// MARK: - Hashable
extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquatable.hashValue
    }
}

// MARK: - Equatable
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquatable == rhs.proxyForEquatable
    }
}

// MARK: - Comparable
extension Person : Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparable < rhs.proxyForComparable
    }
}




