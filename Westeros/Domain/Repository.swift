//
//  Repository.swift
//  Westeros
//
//  Created by luis gomez alonso on 13/2/18.
//  Copyright © 2018 luis gomez alonso. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias Filter = (House) -> Bool
    var houses: [House] { get }
    func house(named: String) -> House?
    func houses(filteredBy: Filter) -> [House]
}

protocol SeasonFactory {
    typealias FilterSeason = (Season) -> Bool
    var seasons: [Season] { get }
    func seasons(filteredBy: FilterSeason) -> [Season]
}

final class LocalFactory: HouseFactory {
    // HOUSES
    var houses: [House] {
        // Houses creation here
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: SigilDescriptions.starkSigil.rawValue)
        let starkHouse = House(name: HouseNames.Stark.rawValue, sigil: starkSigil, words: HouseWords.starkWord.rawValue, url: URL(string: URLs.starkURL.rawValue)!)
        
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: SigilDescriptions.lannisterSigil.rawValue)
        let lannisterHouse = House(name: HouseNames.Lannister.rawValue, sigil: lannisterSigil, words: HouseWords.lannisterWord.rawValue, url: URL(string: URLs.lannisterURL.rawValue)!)
        
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryenSmall.jpg"), description: SigilDescriptions.lannisterSigil.rawValue)
        let targaryenHouse = House(name: HouseNames.Targaryen.rawValue, sigil: targaryenSigil, words: HouseWords.targaryenWord.rawValue, url: URL(string: URLs.targaryenURL.rawValue)!)
        
        let robb = Person(name: Persons.Robb.rawValue, alias: Alias.RobbAlias.rawValue, house: starkHouse, image: UIImage(named: Images.RobbImage.rawValue)!)
        let arya = Person(name: Persons.Arya.rawValue, house: starkHouse, image: UIImage(named: Images.AryaImage.rawValue)!)
        
        let tyrion = Person(name: Persons.Tyrion.rawValue, alias: Alias.TyrionAlias.rawValue, house: lannisterHouse, image: UIImage(named: Images.TyrionImage.rawValue)!)
        let jaime = Person(name: Persons.Jaime.rawValue, alias: Alias.JaimeAlias.rawValue, house: lannisterHouse, image: UIImage(named: Images.JaimeImage.rawValue)!)
        let cersei = Person(name: Persons.Cersei.rawValue, house: lannisterHouse, image: UIImage(named: Images.CerseiImage.rawValue)!)
        
        let daenerys = Person(name: Persons.Daenerys.rawValue, alias: Alias.DaenerysAlias.rawValue, house: targaryenHouse, image: UIImage(named: Images.DaenerysImage.rawValue)!)
        
        // Add characters to houses
        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: cersei, jaime, tyrion)
        targaryenHouse.add(persons: daenerys)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
 
    }
    
    func house(named name: String) -> House? {
        let house = houses.first{ $0.name.uppercased() == name.uppercased() }
        return house
    }
    
    func house(named name: HouseNames) -> House? {
        let house = houses.first{ $0.name == name.rawValue }
        return house
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
}

extension LocalFactory: SeasonFactory {
    // SEASONS
    var seasons: [Season] {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        
        //Season 1
        let season1 = Season(name: SeasonName.S1.rawValue, releaseDate: formatter.date(from: "17/04/2011")!, image: UIImage(named: Images.S01.rawValue)!)
        let s01e01 = Episode(title: EpisodeTitle.S01e01.rawValue, emisionDate: formatter.date(from: "17/04/2011")!, season: season1, image: UIImage(named: Images.S1x1.rawValue)!)
        let s01e02 = Episode(title: EpisodeTitle.S01e02.rawValue, emisionDate: formatter.date(from: "24/04/2011")!, season: season1, image: UIImage(named: Images.S1x2.rawValue)!)
        
        season1.add(episode: s01e01)
        season1.add(episode: s01e02)
        
        //Season 2
        let season2 = Season(name: SeasonName.S2.rawValue, releaseDate: formatter.date(from: "01/04/2012")!, image: UIImage(named: Images.S02.rawValue)!)
        let s02e01 = Episode(title: EpisodeTitle.S02e01.rawValue, emisionDate: formatter.date(from: "01/04/2012")!, season: season2, image: UIImage(named: Images.S2x1.rawValue)!)
        let s02e02 = Episode(title: EpisodeTitle.S02e02.rawValue, emisionDate: formatter.date(from: "08/04/2012")!, season: season2, image: UIImage(named: Images.S2x2.rawValue)!)
        
        season2.add(episode: s02e01)
        season2.add(episode: s02e02)
        
        //Season 3
        let season3 = Season(name: SeasonName.S3.rawValue, releaseDate: formatter.date(from: "31/03/2013")!, image: UIImage(named: Images.S03.rawValue)!)
        let s03e01 = Episode(title: EpisodeTitle.S03e01.rawValue, emisionDate: formatter.date(from: "31/03/2013")!, season: season3, image: UIImage(named: Images.S3x1.rawValue)!)
        let s03e02 = Episode(title: EpisodeTitle.S03e02.rawValue, emisionDate: formatter.date(from: "07/04/2013")!, season: season3, image: UIImage(named: Images.S3x2.rawValue)!)
        
        season3.add(episode: s03e01)
        season3.add(episode: s03e02)
        
        //Season 4
        let season4 = Season(name: SeasonName.S4.rawValue, releaseDate: formatter.date(from: "06/04/2014")!, image: UIImage(named: Images.S04.rawValue)!)
        let s04e01 = Episode(title: EpisodeTitle.S04e01.rawValue, emisionDate: formatter.date(from: "06/04/2014")!, season: season4, image: UIImage(named: Images.S4x1.rawValue)!)
        let s04e02 = Episode(title: EpisodeTitle.S04e02.rawValue, emisionDate: formatter.date(from: "07/04/2014")!, season: season4, image: UIImage(named: Images.S4x2.rawValue)!)
        
        season4.add(episode: s04e01)
        season4.add(episode: s04e02)
        
        //Season 5
        let season5 = Season(name: SeasonName.S5.rawValue, releaseDate: formatter.date(from: "12/04/2015")!, image: UIImage(named: Images.S05.rawValue)!)
        let s05e01 = Episode(title: EpisodeTitle.S05e01.rawValue, emisionDate: formatter.date(from: "19/04/2015")!, season: season5, image: UIImage(named: Images.S5x1.rawValue)!)
        let s05e02 = Episode(title: EpisodeTitle.S05e02.rawValue, emisionDate: formatter.date(from: "19/04/2015")!, season: season5, image: UIImage(named: Images.S5x2.rawValue)!)
        
        season5.add(episode: s05e01)
        season5.add(episode: s05e02)
        
        //Season 6
        let season6 = Season(name: SeasonName.S6.rawValue, releaseDate: formatter.date(from: "24/04/2016")!, image: UIImage(named: Images.S06.rawValue)!)
        let s06e01 = Episode(title: EpisodeTitle.S06e01.rawValue, emisionDate: formatter.date(from: "24/04/2016")!, season: season6, image: UIImage(named: Images.S6x1.rawValue)!)
        let s06e02 = Episode(title: EpisodeTitle.S01e01.rawValue, emisionDate: formatter.date(from: "01/05/2016")!, season: season6, image: UIImage(named: Images.S6x2.rawValue)!)
        
        season6.add(episode: s06e01)
        season6.add(episode: s06e02)
        
        //Season 7
        let season7 = Season(name: SeasonName.S7.rawValue, releaseDate: formatter.date(from: "16/07/2017")!, image: UIImage(named: Images.S07.rawValue)!)
        let s07e01 = Episode(title: EpisodeTitle.S07e01.rawValue, emisionDate: formatter.date(from: "16/07/2017")!, season: season7, image: UIImage(named: Images.S7x1.rawValue)!)
        let s07e02 = Episode(title: EpisodeTitle.S07e02.rawValue, emisionDate: formatter.date(from: "23/07/2017")!, season: season7, image: UIImage(named: Images.S7x2.rawValue)!)
        
        season7.add(episode: s07e01)
        season7.add(episode: s07e02)
        
        return [season1,season2,season3,season4,season5,season6,season7].sorted()
    }
    
    func seasons(filteredBy: FilterSeason) -> [Season] {
        return seasons.filter(filteredBy)
    }
}

