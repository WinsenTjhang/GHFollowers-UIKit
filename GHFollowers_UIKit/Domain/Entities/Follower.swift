//
//  Follower.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 09/07/24.

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
}

extension Follower {
    static let placeholder: Follower =
        Follower(login: "",
                 avatarUrl: "")
    
    static let sampleFollower: Follower =
        Follower(login: User.sampleUser.login,
                  avatarUrl: User.sampleUser.avatarUrl)
    
}
