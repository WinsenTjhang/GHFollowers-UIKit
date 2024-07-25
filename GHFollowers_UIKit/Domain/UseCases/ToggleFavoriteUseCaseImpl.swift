//
//  ToggleFavoriteUseCaseImpl.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 16/07/24.
//

import Combine

class ToggleFavoriteUseCaseImpl: ToggleFavoriteUseCase {
    private let repository: FavoritesRepositoryInterface
    
    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }
    
    func execute(user: User) -> AnyPublisher<Bool, Error> {
        return repository.toggleFavorite(user)
    }
}
