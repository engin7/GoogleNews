//
//  Model.swift
//  GoogleNews
//
//  Created by Engin KUK on 15.10.2020.
//

import Foundation

struct Root:  Codable {
    let articles : [News]
}

struct News: Codable {
    
    let source : Source
    var author         = ""
    var title          = ""
    var image          = ""
    var description    = ""
    var url            = ""
    var urlToImage     = ""
    var publishedAt    = ""
    var content        = ""
    
//    enum CodingKeys: String, CodingKey {
//      // API keywords clear enough no need to use CodingKeys
//    }
    
    struct Source: Codable {
        var id = 0
        var name = ""
    }
}

