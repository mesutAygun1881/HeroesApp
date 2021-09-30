//
//  HeroesModel.swift
//  HeroesApp
//
//  Created by Mesut Aygün on 30.09.2021.
//

import Foundation


struct heroesModel : Decodable {
    let name : String
    let localized_name : String
    let primary_attr : String
    let attack_type : String
    let legs : Int
    let img : String
}
