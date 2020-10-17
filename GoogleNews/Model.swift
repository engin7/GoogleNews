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
 
    let source : Source?
    var title          : String?
    var url            : String?
    var publishedAt    : String?
    var author         : String?
    var description    : String?
    var content        : String?
    var urlToImage     : String?

//    enum CodingKeys: String, CodingKey {
//      // API keywords clear enough, no need to use CodingKeys
//    }
    
}

struct Source: Codable {
    var id: String?
    var name = ""
}
