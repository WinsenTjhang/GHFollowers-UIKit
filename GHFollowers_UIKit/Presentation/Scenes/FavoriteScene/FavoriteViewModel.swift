//
//  FavoriteViewModel.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 15/07/24.
//

import Combine
import Foundation

class FavoriteViewModel {
    private let fetchFavoritesUseCase: FetchFavoritesUseCase
    private let removeFavoriteUseCase: RemoveFavoriteUseCase
    private let fetchImageUseCase: FetchImageUseCase
    private var cancellables = Set<AnyCancellable>()
        
    @Published private(set) var favorites: [User] = []
    @Published private(set) var errorMessage: String?
    
    init(fetchFavoritesUseCase: FetchFavoritesUseCase,
         removeFavoriteUseCase: RemoveFavoriteUseCase,
         fetchImageUseCase: FetchImageUseCase) {
        self.fetchFavoritesUseCase = fetchFavoritesUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.fetchImageUseCase = fetchImageUseCase
    }
    
    func fetchFavorites() {
        fetchFavoritesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] favoriteUsers in
                self?.favorites = favoriteUsers
            }
            .store(in: &cancellables)
    }
    
    func removeFavorite(_ user: User) {
        removeFavoriteUseCase.execute(user: user)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.fetchFavorites()
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func getFetchImageUseCase() -> FetchImageUseCase {
        return fetchImageUseCase
    }
}
