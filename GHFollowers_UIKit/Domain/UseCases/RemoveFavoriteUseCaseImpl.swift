//
//  RemoveFavoriteUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

class RemoveFavoriteUseCaseImpl: RemoveFavoriteUseCase {
    private let repository: FavoritesRepositoryInterface
    
    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }
    
    func execute(user: User) -> AnyPublisher<Void, Error> {
        return repository.removeFavorite(user)
    }
}
