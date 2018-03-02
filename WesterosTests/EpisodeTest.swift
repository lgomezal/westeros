//
//  EpisodeTest.swift
//  WesterosTests
//
//  Created by luis gomez alonso on 23/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTest: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    
    var episode1: Episode!
    var episode2: Episode!
    var episode11: Episode!
    
    override func setUp() {
        super.setUp()
        season1 = Season(name: "Temporada 1", releaseDate: Date(timeIntervalSinceNow: -10000), image: UIImage(named: "S01")!)
        season2 = Season(name: "Temporada 2", releaseDate: Date(timeIntervalSinceNow: -7000), image: UIImage(named: "S01")!)
        
        episode1 = Episode(title: "Episodio 1", emisionDate: Date(timeIntervalSinceNow: -9500), season: season1, image: UIImage(named: "1x1.jpg")!)
        episode2 = Episode(title: "Episodio 2", emisionDate: Date(timeIntervalSinceNow: -6900), season: season1, image: UIImage(named: "2x1.jpg")!)
        
        episode11 = Episode(title: "Episodio 11", emisionDate: Date(timeIntervalSinceNow: -5650), season: season2, image: UIImage(named: "2x1.jpg")!)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
    }
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(episode1, episode1)
        
        // Igualdad
        let episode1p = Episode(title: "Episodio 1", emisionDate: Date(timeIntervalSinceNow: -9500), season: season1, image: UIImage(named: "1x1.jpg")!)
        XCTAssertEqual(episode1p, episode1)
        
        // Desigualdad
        XCTAssertNotEqual(episode1, episode2)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(episode1, episode2)
    }
    
    func testCustomStringConvertible() {
        XCTAssertEqual(episode1.title, "Episodio 1")
    }
    
    
}
