//
//  FetchImageUseCaseImpl.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import UIKit
import Combine

class FetchImageUseCaseImpl: FetchImageUseCase {
    private let repository: GitHubRepository
    
    init(repository: GitHubRepository) {
        self.repository = repository
    }
    
    func execute(from url: URL) -> AnyPublisher<UIImage, Error> {
        return repository.fetchImage(from: url)
    }
}
