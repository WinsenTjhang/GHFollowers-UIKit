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
            .map { dtos in dtos.map { User(from: $0) } }
            .eraseToAnyPublisher()
    }
}
