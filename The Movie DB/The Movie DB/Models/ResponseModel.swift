//
//  ResponseModel.swift
//  The Movie DB
//
//  Created by JiTHiN on 10/02/25.
//

import Foundation
struct ResponseModel: Decodable{
    var page : Int
    var results : [PopularPeopleModel]
    var totalPages : Int
    var totalResults : Int
    
    enum CodingKeys : String,CodingKey{
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
