//
//  UserDTO.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Foundation

struct UserDTO: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let htmlUrl: String?
    let following: Int?
    let followers: Int?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case login, name, location, bio, following, followers
        case avatarUrl = "avatar_url"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case htmlUrl = "html_url"
        case createdAt = "created_at"
    }
    
}
