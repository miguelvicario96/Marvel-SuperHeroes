//
//  SuperHero.swift
//  MarvelSuperHeroes
//
//  Created by Miguel Vicario on 11/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

//MARK: - Superheroes - Codable
public struct Superheroes: Codable {
    
    //MARK: - Instance Properties
    let superheroes: [Superhero]
}

//MARK: - Superhero - Codable
public struct Superhero: Codable {
    
    //MARK: - Instance Properties
    let name: String
    let photo: String
    let realName, height, power, abilities: String
    let groups: String
}
