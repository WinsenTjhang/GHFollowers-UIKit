//
//  SaveFavoriteUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

class SaveFavoriteUseCase {
    private let repository: FavoritesRepository
    
    init(repository: FavoritesRepository) {
        self.repository = repository
    }
    
    func execute(user: User) -> AnyPublisher<Void, Error> {
        return repository.saveFavorite(user)
    }
}
