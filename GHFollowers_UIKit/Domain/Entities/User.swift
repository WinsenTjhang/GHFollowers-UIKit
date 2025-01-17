//
//  User.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 09/07/24.

import Foundation

struct User {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let htmlUrl: String
    let following: Int?
    let followers: Int?
    let createdAt: Date?
    
    init(from dto: UserDTO) {
        self.login = dto.login
        self.avatarUrl = dto.avatarUrl
        self.name = dto.name
        self.location = dto.location
        self.bio = dto.bio
        self.publicRepos = dto.publicRepos
        self.publicGists = dto.publicGists
        self.htmlUrl = dto.htmlUrl ?? ""
        self.following = dto.following
        self.followers = dto.followers
        self.createdAt = dto.createdAt.flatMap { ISO8601DateFormatter().date(from: $0) }
    }
    
    func toDTO() -> UserDTO {
        return UserDTO(
            login: login,
            avatarUrl: avatarUrl,
            name: name,
            location: location,
            bio: bio,
            publicRepos: publicRepos,
            publicGists: publicGists,
            htmlUrl: htmlUrl,
            following: following,
            followers: followers,
            createdAt: createdAt.map { ISO8601DateFormatter().string(from: $0) }
        )
    }
}

extension User {
    static let placeholder: User = {
        let dto = UserDTO(
            login: "",
            avatarUrl: "",
            name: nil,
            location: nil,
            bio: nil,
            publicRepos: 0,
            publicGists: 0,
            htmlUrl: "https://www.github.com",
            following: 0,
            followers: 0,
            createdAt: nil
        )
        return User(from: dto)
    }()
    
    static let sampleUser: User = {
        let dto = UserDTO(
            login: "wStockhausen",
            avatarUrl: "https://avatars.githubusercontent.com/u/10645516?v=4",
            name: "John Appleseed",
            location: "Cupertino, CA",
            bio: "Swift addict",
            publicRepos: 9,
            publicGists: 41,
            htmlUrl: "https://github.com",
            following: 1984,
            followers: 270,
            createdAt: nil
        )
        return User(from: dto)
    }()
}

