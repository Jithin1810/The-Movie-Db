//
//  PopularPeopleModel.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import Foundation

struct PopularPeopleModel : Decodable{
    var id : Int
    var name : String
    var originalName : String
    var department : String
    var profilePath : String
    
    enum CodingKeys : String,CodingKey{
        case id = "id"
        case name = "name"
        case originalName = "original_name"
        case department = "known_for_department"
        case profilePath = "profile_path"
    }
}
