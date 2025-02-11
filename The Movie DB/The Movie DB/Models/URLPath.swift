//
//  URLPath.swift
//  The Movie DB
//
//  Created by JiTHiN on 11/02/25.
//

import Foundation
struct ImageURLBuilder{
    private static let baseUrl = "https://image.tmdb.org/t/p/w500"
    static func getUrl(with: String) -> String{
        return baseUrl + with
    }
}
