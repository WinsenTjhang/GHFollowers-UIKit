//
//  UserRepositoryImpl.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import UIKit
import Combine

class GithubRepository: GitHubRepositoryInterface {
    private let networkService: NetworkService
    private let imageCache: NSCache<NSString, UIImage>
    
    init(networkService: NetworkService, imageCache: NSCache<NSString, UIImage>) {
        self.networkService = networkService
        self.imageCache = imageCache
    }
    
    func fetchFollowers(for username: String, page: Int) -> AnyPublisher<[User], Error> {
        let endpoint = "https://api.github.com/users/\(username)/followers?per_page=100&page=\(page)"
        return networkService.get(url: endpoint)
            .decode(type: [UserDTO].self, decoder: JSONDecoder())
            .map { userDTOs in
                userDTOs.map { User(from: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchUserDetail(for username: String) -> AnyPublisher<User, Error> {
        let endpoint = "https://api.github.com/users/\(username)"
        return networkService.get(url: endpoint)
            .decode(type: UserDTO.self, decoder: JSONDecoder())
            .map { dto in
                User(from: dto)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchImage(from url: URL) -> AnyPublisher<UIImage, Error> {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return Just(cachedImage)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return networkService.getData(url: url.absoluteString)
            .compactMap { UIImage(data: $0) }
            .handleEvents(receiveOutput: { [weak self] image in
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            })
            .eraseToAnyPublisher()
    }
    
    
}
