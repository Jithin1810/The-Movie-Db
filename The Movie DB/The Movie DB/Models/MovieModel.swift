//
//  MovieModel.swift
//  The Movie DB
//
//  Created by JiTHiN on 11/02/25.
//

import Foundation
struct Movies : Decodable{
    var backdropPath : String?
    var id : Int
    var originalTitle : String?
    var overview : String?
    var posterPath : String?
    var mediaType : String?
    
    enum CodingKeys : String,CodingKey{
        case backdropPath = "backdrop_path"
        case id = "id"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case mediaType = "media_type"
    }
}
