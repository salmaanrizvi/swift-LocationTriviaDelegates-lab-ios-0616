//
//  Location.swift
//
//
//  Created by Haaris Muneer on 7/18/16.
//
//

import UIKit

class Location {
    var name: String
    var trivia: [Trivium]
    
    init (name: String, trivia: [Trivium]) {
        self.name = name
        self.trivia = trivia
    }
}

class Trivium {
    var content: String
    var likes: Int = 0
    
    init (content: String, likes: Int) {
        self.content = content
        self.likes = likes
    }
}
