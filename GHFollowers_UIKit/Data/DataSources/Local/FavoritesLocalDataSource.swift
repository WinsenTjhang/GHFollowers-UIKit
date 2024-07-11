//
//  FavoritesLocalDataSource.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 11/07/24.
//

import Combine
import Foundation

protocol FavoritesLocalDataSource {
    func saveFavorite(_ user: UserDTO) -> AnyPublisher<Void, Error>
    func removeFavorite(_ user: UserDTO) -> AnyPublisher<Void, Error>
    func getFavorites() -> AnyPublisher<[UserDTO], Error>
}

protocol DataSourceProvider {
    var favoritesLocalDataSource: FavoritesLocalDataSource { get }
}

class UserDefaultsFavoritesLocalDataSource: FavoritesLocalDataSource {
    private let userDefaults: UserDefaults
    private let favoritesKey = "favorites"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveFavorite(_ user: UserDTO) -> AnyPublisher<Void, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            var favorites = self.getFavoritesFromUserDefaults()
            favorites.append(user)
            
            do {
                let encodedData = try JSONEncoder().encode(favorites)
                self.userDefaults.set(encodedData, forKey: self.favoritesKey)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeFavorite(_ user: UserDTO) -> AnyPublisher<Void, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            var favorites = self.getFavoritesFromUserDefaults()
            favorites.removeAll { $0.login == user.login }
            
            do {
                let encodedData = try JSONEncoder().encode(favorites)
                self.userDefaults.set(encodedData, forKey: self.favoritesKey)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavorites() -> AnyPublisher<[UserDTO], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            let favorites = self.getFavoritesFromUserDefaults()
            promise(.success(favorites))
        }.eraseToAnyPublisher()
    }
    
    private func getFavoritesFromUserDefaults() -> [UserDTO] {
        guard let data = userDefaults.data(forKey: favoritesKey) else { return [] }
        
        do {
            return try JSONDecoder().decode([UserDTO].self, from: data)
        } catch {
            print("Error decoding favorites: \(error)")
            return []
        }
    }
}
