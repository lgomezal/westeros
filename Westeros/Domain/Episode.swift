//
//  Episode.swift
//  Westeros
//
//  Created by luis gomez alonso on 23/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import Foundation
import UIKit

final class Episode {
    let title: String
    let emisionDate: Date
    let season: Season
    let image: UIImage
    
    init(title: String, emisionDate: Date, season: Season, image: UIImage) {
        self.title = title
        self.emisionDate = emisionDate
        self.season = season
        self.image = image
    }
}

// MARK: - Proxies
extension Episode {
    var proxy: String {
        return "\(season.name) \(emisionDate) \(title)"
    }
}

// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxy.hashValue
    }
}

// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

// MARK: - Comparable
extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxy < rhs.proxy
    }
}

// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        return "\(title)"
    }
}


