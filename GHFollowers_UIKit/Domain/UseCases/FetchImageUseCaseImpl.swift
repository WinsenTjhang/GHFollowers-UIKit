//
//  FetchImageUseCaseImpl.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import UIKit
import Combine

class FetchImageUseCaseImpl: FetchImageUseCase {
    private let repository: GitHubRepositoryInterface
    
    init(repository: GitHubRepositoryInterface) {
        self.repository = repository
    }
    
    func execute(from url: String) -> AnyPublisher<UIImage, Error> {
        return repository.fetchImage(from: url)
    }
}
