//
//  FetchFavoritesUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

class FetchFavoritesUseCaseImpl {
    private let repository: FavoritesRepository
    
    init(repository: FavoritesRepository) {
        self.repository = repository
    }
    
    func execute(user: User) -> AnyPublisher<[User], Error> {
        return repository.fetchFavorites()
    }
}
