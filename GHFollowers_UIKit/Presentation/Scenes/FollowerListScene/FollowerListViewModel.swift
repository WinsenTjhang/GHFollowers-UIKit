//
//  FollowerListViewModel.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 15/07/24.
//

import Foundation
import Combine

class FollowerListViewModel {

    @Published private(set) var followers: [User] = []
    @Published private(set) var error: Error?
    @Published private(set) var isFavorite: Bool = false
    @Published private(set) var isLoading: Bool = false
    
    let username: String
    let fetchImageUseCase: FetchImageUseCase
    
    private(set) var user: User = User.sampleUser
    
    private let fetchUserDetailUseCase: FetchUserDetailUseCase
    private let fetchFollowersUseCase: FetchFollowersUseCase
    private let toggleFavoriteUseCase: ToggleFavoriteUseCase
    private let checkFavoriteStatusUseCase: CheckFavoriteStatusUseCase
    private var currentPage = 1
    private var hasMorePages = false
    private var cancellables = Set<AnyCancellable>()
    
    init(username: String,
         fetchFollowersUseCase: FetchFollowersUseCase,
         toggleFavoriteUseCase: ToggleFavoriteUseCase,
         checkFavoriteStatusUseCase: CheckFavoriteStatusUseCase,
         fetchImageUseCase: FetchImageUseCase,
         fetchUserDetailUseCase: FetchUserDetailUseCase) {
        self.username = username
        self.fetchFollowersUseCase = fetchFollowersUseCase
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
        self.checkFavoriteStatusUseCase = checkFavoriteStatusUseCase
        self.fetchImageUseCase = fetchImageUseCase
        self.fetchUserDetailUseCase = fetchUserDetailUseCase
        
        fetchUser()
        getFollowers()
    }
    
    func getNextPage() {
        guard hasMorePages && !isLoading else { return }
        currentPage += 1
        getFollowers()
    }
    
    func toggleFavorite() {
        toggleFavoriteUseCase.execute(user: user)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] _ in
                self?.isFavorite.toggle()
            }
            .store(in: &cancellables)
    }
    
    private func fetchUser() {
        fetchUserDetailUseCase.execute(for: username)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.checkFavoriteStatus()
            }
            .store(in: &cancellables)
    }
    
    private func getFollowers() {
        guard !isLoading else { return }
        
        isLoading = true
        fetchFollowersUseCase.execute(for: username, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] newFollowers in
                self?.hasMorePages = newFollowers.count == 20  // Assuming 20 is the page size
                self?.followers.append(contentsOf: newFollowers)
            }
            .store(in: &cancellables)
    }
    
    private func checkFavoriteStatus() {
        checkFavoriteStatusUseCase.execute(user: user)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] isFavorite in
                self?.isFavorite = isFavorite
            }
            .store(in: &cancellables)
    }
}
