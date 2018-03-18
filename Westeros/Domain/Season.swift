//
//  Season.swift
//  Westeros
//
//  Created by luis gomez alonso on 23/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import Foundation
import UIKit

typealias Episodes = Set<Episode>

final class Season {
    let name: String
    let releaseDate: Date
    let image: UIImage
    private var _episodes: Episodes
    
    init(name: String, releaseDate: Date, image: UIImage) {
        self.name = name
        self.releaseDate = releaseDate
        self.image = image
        _episodes = Episodes()
    }
    
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    // Devuelve un array ordenado de episodios
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        guard episode.season == self else {
            return
        }
        _episodes.insert(episode)
    }
}

// MARK: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate)"
    }
    
    //var proxyForComparison: String {
    //    return name.uppercased()
    //}
    
    var proxyForComparison: Date {
        return releaseDate
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "\(name)"
    }
}









