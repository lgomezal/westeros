//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by luis gomez alonso on 23/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    
    var episode1: Episode!
    var episode2: Episode!
    var episode11: Episode!
    
    override func setUp() {
        super.setUp()
        season1 = Season(name: "Temporada 1", releaseDate: Date(timeIntervalSinceNow: -10000), image: UIImage(named: "S01")!)
        season2 = Season(name: "Temporada 2", releaseDate: Date(timeIntervalSinceNow: -7000), image: UIImage(named: "S02")!)
        
        episode1 = Episode(title: "Episodio 1", emisionDate: Date(timeIntervalSinceNow: -9500), season: season1, image: UIImage(named: "1x1.jpg")!)
        episode2 = Episode(title: "Episodio 2", emisionDate: Date(timeIntervalSinceNow: -6900), season: season1, image: UIImage(named: "1x2.jpg")!)
        
        episode11 = Episode(title: "Episodio 11", emisionDate: Date(timeIntervalSinceNow: -5650), season: season2, image: UIImage(named: "2x1.jpg")!)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
    }
    
    func testAddEpisode() {
        XCTAssertEqual(season1.count, 0)
        
        season1.add(episode: episode1)
        XCTAssertEqual(season1.count, 1)
        
        season1.add(episode: episode2)
        XCTAssertEqual(season1.count, 2)
        
        season1.add(episode: episode11)
        XCTAssertEqual(season1.count, 2)
        
    }
    
    func testSeasonEquality() {
        // Identidad
        XCTAssertEqual(season1, season1)
        
        // Igualdad
        let season1p = Season(name: "Temporada 1", releaseDate: Date(timeIntervalSinceNow: -10000), image: UIImage(named: "S01")!)
        XCTAssertEqual(season1p, season1)
        
        // Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
    func testCustomStringConvertible() {
        XCTAssertEqual(season1.name, "Temporada 1")
    }
    
}
