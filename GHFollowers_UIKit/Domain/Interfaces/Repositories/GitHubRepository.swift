//
//  UserRepository.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import UIKit
import Combine

protocol GitHubRepository {
    func fetchFollowers(for username: String, page: Int) -> AnyPublisher<[User], Error>
    func fetchUserDetail(for username: String) -> AnyPublisher<User, Error>
    func fetchImage(from url: URL) -> AnyPublisher<UIImage, Error>
}
