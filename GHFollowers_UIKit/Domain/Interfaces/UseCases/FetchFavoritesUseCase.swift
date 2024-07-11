//
//  FetchFavoritesUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

protocol FetchFavoritesUseCase {
    func execute() -> AnyPublisher<[User], Error>
}
