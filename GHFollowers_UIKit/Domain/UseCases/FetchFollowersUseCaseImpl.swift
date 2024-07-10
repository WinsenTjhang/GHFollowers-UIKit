//
//  FetchFollowersUseCaseImpl.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Foundation
import Combine

class FetchFollowersUseCaseImpl: FetchFollowersUseCase {
    private let repository: GitHubRepository
    
    init(repository: GitHubRepository) {
        self.repository = repository
    }
    
    func execute(for username: String, page: Int) -> AnyPublisher<[User], Error> {
        return repository.fetchFollowers(for: username, page: page)
    }
    
}
