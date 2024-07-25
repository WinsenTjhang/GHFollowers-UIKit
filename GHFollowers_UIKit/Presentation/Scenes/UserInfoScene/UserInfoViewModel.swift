//
//  UserInfoViewModel.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 22/07/24.
//

import UIKit
import Combine

class UserInfoViewModel {
    @Published private(set) var user: User?
    @Published var avatarImage: UIImage?
    @Published private(set) var errorMessage: String?
    private(set) var username: String
    
    private var fetchImageUseCase: FetchImageUseCase
    private let fetchUserDetailUseCase: FetchUserDetailUseCase
    private var cancellables = Set<AnyCancellable>()
    
    
    init(fetchUserDetailUseCase: FetchUserDetailUseCase, fetchImageUseCase: FetchImageUseCase, username: String) {
        self.fetchImageUseCase = fetchImageUseCase
        self.username = username
        self.fetchUserDetailUseCase = fetchUserDetailUseCase
        
        fetchUser()
    }
    
    private func fetchUser() {
        fetchUserDetailUseCase.execute(for: username)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.loadImage()
            }
            .store(in: &cancellables)
    }
    
    private func loadImage() {
//        guard let avatarUrl = user.avatarUrl else {
//            self.avatarImage = UIImage(systemName: "person.circle")
//            return
//        }
        
        fetchImageUseCase.execute(from: user!.avatarUrl)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.avatarImage = UIImage(systemName: "person.circle")
                    }
                },
                receiveValue: { [weak self] image in
                    self?.avatarImage = image
                }
            )
            .store(in: &cancellables)
    }
}
