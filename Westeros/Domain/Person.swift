//
//  Character.swift
//  Westeros
//
//  Created by luis gomez alonso on 8/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import Foundation
import UIKit

final class Person: Decodable {
    let name: String
    let house: House
    private let imageName: String
    var image: UIImage? {
        get {
            return UIImage(named: imageName, in: Bundle(for: type(of: self)), compatibleWith: nil)
        }
    }
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
    
    private enum CodingKeys: String, CodingKey {
        case name, house
        case imageName = "imagePerson"
        case _alias = "alias"
    }
    
    init(name: String, alias: String? = nil, house: House, image: String) {
        self.name = name
        _alias = alias
        self.house = house
        self.imageName = image
        
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




