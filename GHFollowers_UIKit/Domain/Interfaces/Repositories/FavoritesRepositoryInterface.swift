//
//  FavoritesRepository.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

protocol FavoritesRepositoryInterface {
    func saveFavorite(_ user: User) -> AnyPublisher<Void, Error>
    func removeFavorite(_ user: User) -> AnyPublisher<Void, Error>
    func getFavorites() -> AnyPublisher<[User], Error>
    func toggleFavorite(_ user: User) -> AnyPublisher<Bool, Error>
    func checkFavoriteStatus(_ user: User) -> AnyPublisher<Bool, Error>
}
