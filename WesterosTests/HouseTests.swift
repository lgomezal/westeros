//
//  HouseTests.swift
//  WesterosTests
//
//  Created by luis gomez alonso on 8/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import XCTest
@testable import Westeros
class HouseTests: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp() {
        super.setUp()
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterSigil = Sigil(image: UIImage(), description: "Leon Rampante")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        
        robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse, image: UIImage(named: "Robb_Stark")!)
        arya = Person(name: "Arya", house: starkHouse, image: UIImage(named: "Arya_Stark")!)
        
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse, image: UIImage(named: "Tyrion_Lannister")!)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHouseExistence() {
        
        XCTAssertNotNil(starkHouse)
        XCTAssertNotNil(lannisterHouse)
    }
    
    func testSigilExistenc() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testAddPersons() {
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
        
        let cersei = Person(name: "Cersei", house: lannisterHouse, image: UIImage(named: "Cersei_Lannister")!)
        let jaime = Person(name: "Jaime", alias: "El Matareyes", house: lannisterHouse, image: UIImage(named: "Jaime_Lannister")!)
        lannisterHouse.add(persons: cersei, jaime)
        XCTAssertEqual(lannisterHouse.count, 3)
    }
    
    func testHouseEquality() {
        // Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Igualdad
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        let robb = Person(name: "Robb", alias: "El joven lobo", house: jinxed, image: UIImage(named: "Robb_Stark")!)
        let arya = Person(name: "Arya", house: jinxed, image: UIImage(named: "Arya_Stark")!)
        jinxed.add(persons: robb, arya)
        XCTAssertEqual(jinxed, starkHouse)
        
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testReturnsSortedArrayOfPersons() {
        let persons = starkHouse.sortedMembers
        XCTAssertEqual(persons, persons.sorted())
    }
    
    
    
    
}
