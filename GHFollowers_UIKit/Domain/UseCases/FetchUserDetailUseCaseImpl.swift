//
//  FetchUserDetailUseCaseImpl.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Foundation
import Combine

class FetchUserDetailUseCaseImpl: FetchUserDetailUseCase {
private let repository: GitHubRepository
    
    init(repository: GitHubRepository) {
        self.repository = repository
    }
    
    func execute(for username: String) -> AnyPublisher<User, Error> {
        repository.fetchUserDetail(for: username)
    }
    
}
