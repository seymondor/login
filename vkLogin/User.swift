//
//  User.swift
//  vkLogin
//
//  Created by Максим Машковский on 11.05.2024.
//

import Foundation
import SwiftUI

//public var user1 = User(username: "MRMike", imagePost: "forest")
//public var user2 = User(username: "masterPaul", imagePost: "forest1")
//public var user3 = User(username: "missKate", imagePost: "forest1")

public var testSSS = [ User(id: 0, username: "MRMike", likes: 9, imagePost: "forest", isLikePressed: false),
                       User(id: 1, username: "masterPaul", likes: 4, imagePost: "forest1", isLikePressed: false),
                       User(id: 2, username: "missKate", likes: 0, imagePost: "forest1", isLikePressed: false)]

public struct User: Hashable {
    var id : Int
    var username : String
    var likes : Int //= Int.random(in: 0..<10)
    var imagePost : String
    var isLikePressed : Bool //= false
}

