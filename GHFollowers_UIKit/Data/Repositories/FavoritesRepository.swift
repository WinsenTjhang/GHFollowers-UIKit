//
//  FavoritesRepository.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 11/07/24.
//

import Foundation
import Combine

class FavoritesRepository: FavoritesRepositoryInterface {
    private let localDataSource: FavoritesLocalDataSource
    
    init(localDataSource: FavoritesLocalDataSource = UserDefaultsFavoritesLocalDataSource()) {
        self.localDataSource = localDataSource
    }
    
    func saveFavorite(_ user: User) -> AnyPublisher<Void, Error> {
        return localDataSource.saveFavorite(user.toDTO())
    }
    
    func removeFavorite(_ user: User) -> AnyPublisher<Void, Error> {
        return localDataSource.removeFavorite(user.toDTO())
    }
    
    func getFavorites() -> AnyPublisher<[User], Error> {
        return localDataSource.getFavorites()
//            .handleEvents(receiveOutput: { userDTOs in
//                        print("Favorties: \(userDTOs)")
//                    })
            .map { dtos in dtos.map { User(from: $0) } }
            .eraseToAnyPublisher()
    }
    
    func toggleFavorite(_ user: User) -> AnyPublisher<Bool, Error> {
        return checkFavoriteStatus(user)
            .flatMap { isFavorite -> AnyPublisher<Bool, Error> in
                if isFavorite {
                    return self.removeFavorite(user).map { false }.eraseToAnyPublisher()
                } else {
                    return self.saveFavorite(user).map { true }.eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func checkFavoriteStatus(_ user: User) -> AnyPublisher<Bool, Error> {
        return getFavorites()
            .map { favorites in favorites.contains { $0.login == user.login } }
            .eraseToAnyPublisher()
    }
}
