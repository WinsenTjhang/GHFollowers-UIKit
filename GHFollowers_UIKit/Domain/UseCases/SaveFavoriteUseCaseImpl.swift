//
//  SaveFavoriteUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

class SaveFavoriteUseCaseImpl: SaveFavoritesUseCase {
    private let repository: FavoritesRepositoryInterface
    
    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }
    
    func execute(user: User) -> AnyPublisher<Void, Error> {
        return repository.saveFavorite(user)
    }
}
