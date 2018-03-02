//
//  RepositoryTest.swift
//  WesterosTests
//
//  Created by luis gomez alonso on 13/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTest: XCTestCase {
    
    var localHouses: [House]!
    var localSeasons: [Season]!
    
    enum HouseNames: String {
        case Stark = "Stark"
        case Lannister = "Lannister"
        case Targaryen = "Targaryen"
    }
    
    override func setUp() {
        super.setUp()
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocalRepositoryCreation() {
        let local = Repository.local
        XCTAssertNotNil(local)
    }
    
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByCaseInsensitively() {
        let stark = Repository.local.house(named: "sTark")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryReturnsHousesByEnum() {
        let stark = Repository.local.house(named: .Stark)
        XCTAssertEqual(stark?.name, "Stark")
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        XCTAssertEqual(filtered.count, 1)
    }
    
    func testLocalRepositorySeasonsCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertEqual(localSeasons.count, 7)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }
    
    func testSeasonFiltering() {
        let filtered = Repository.local.seasons(filteredBy: { $0.count == 2 })
        XCTAssertEqual(filtered.count, 7)
    }
    
}
