//
//  PopularPeopleModel.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import Foundation

struct PopularPeopleModel : Decodable{
    var id : Float
    var name : String
    var originalName : String
    var department : String
    var popularity : Float
    var profilePath : String?
    var gender : Int
    var knownFor : [Movies]
    
    enum CodingKeys : String,CodingKey{
        case id = "id"
        case name = "name"
        case originalName = "original_name"
        case department = "known_for_department"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case gender = "gender"
        case knownFor = "known_for"
    }
}
