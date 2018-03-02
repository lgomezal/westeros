//
//  CharacterTest.swift
//  WesterosTests
//
//  Created by luis gomez alonso on 8/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import XCTest
@testable import Westeros
class PersonTest: XCTestCase {
    
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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCharacterExistence() {
        XCTAssertNotNil(robb)
        XCTAssertNotNil(arya)
    }
    
    func testFullName() {
        XCTAssertEqual(robb.fullName, "Robb Stark")
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(tyrion, tyrion)
        
        // Igualdad
        let enano = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse, image: UIImage(named: "Tyrion_Lannister")!)
        XCTAssertEqual(enano, tyrion)
        
        // Desigualdad
        XCTAssertNotEqual(tyrion, arya)
        
    }
    
}
