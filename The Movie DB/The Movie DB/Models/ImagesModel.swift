//
//  ImagesModel.swift
//  The Movie DB
//
//  Created by JiTHiN on 11/02/25.
//

import Foundation

struct ImagesResponse : Decodable{
    var id : Int
    var profiles : [Images]
}

struct Images : Decodable{
    var filepath : String
    enum CodingKeys : String,CodingKey{
        case filepath = "file_path"
    }
}
