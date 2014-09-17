//
//  MovieModel.swift
//  RottenClient
//
//  Created by Alex Choi on 9/14/14.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

import Foundation

class MovieModel {
    var rawHash: NSDictionary
    var title: String
    var score: Int
    var description: String
    var rating: String
    
    init(fromNSDictionary dictionary: NSDictionary) {
        rawHash = dictionary
        title = rawHash["title"] as String
        description = rawHash["synopsis"] as String
        rating = rawHash["mpaa_rating"] as String
        if let scoreHash = rawHash["score"] as? NSDictionary {
            score = scoreHash["critics_score"] as Int
        } else {
            score = 0
        }
    }
    
    func criticsScore() -> NSString {
        return String((rawHash["ratings"] as NSDictionary)["critics_score"] as NSInteger)
    }
    
    func posterThumbnailUrl() -> NSString {
        return String(((rawHash["posters"] as NSDictionary)["thumbnail"] as String).stringByReplacingOccurrencesOfString("tmb", withString: "ori"))
    }
    
}