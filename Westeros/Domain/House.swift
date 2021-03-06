//
//  House.swift
//  Westeros
//
//  Created by luis gomez alonso on 8/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

typealias Words = String
// Con set nos impide meter duplicados por ese valor
typealias Members = Set<Person>

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members

    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    // Devuelve un array ordenado de personas
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        // Evitar meter un miembro que no es de tu casa
        guard person.house == self else {
            return
        }
        
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        // Aqui persons es de tipo [Person]
        //for person in persons {
        //    add(person: person)
        //}
        persons.forEach{ add(person: $0) }
    }
    
    // Devuelve un array ordenado de personas
    //func sortedMembers()-> [Person] {
    //    return _members.sorted()
    //}
    
}

// MARK: - Proxy
extension House {
    var proxyForEquiality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

// MARK: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquiality == rhs.proxyForEquiality
    }
}

// MARK: - Hashable
extension House: Hashable {
    var hashValue: Int {
        return proxyForEquiality.hashValue
    }
}

// MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - Sigil
final class Sigil {
    let description: String
    let image: UIImage
    
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
}
