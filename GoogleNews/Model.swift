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
    var name           = ""
    var longName       = ""
    var image          = ""
    var totalService   = 0
    var id             = 0
    var serviceId      = 0
    var rating: Float?
    var jobsDone: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalService = "pro_count"
        case image = "image_url"
        case serviceId = "service_id"
        case longName = "long_name"
        case rating = "average_rating"
        case jobsDone = "completed_jobs_on_last_month"
        case id, name, source
    }
    
    struct Source: Codable {
        var id = 0
        var name = ""
    }
}

