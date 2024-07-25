//
//  FetchFavoritesUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

class FetchFavoritesUseCaseImpl: FetchFavoritesUseCase {
    private let repository: FavoritesRepositoryInterface
    
    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[User], Error> {
        return repository.getFavorites()
    }
}
