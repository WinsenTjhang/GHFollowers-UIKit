//
//  FavoritesRepository.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

protocol FavoritesRepository {
    func saveFavorite(_ user: User) -> AnyPublisher<Void, Error>
    func removeFavorite(_ user: User) -> AnyPublisher<Void, Error>
    func fetchFavorites() -> AnyPublisher<[User], Error>
}
