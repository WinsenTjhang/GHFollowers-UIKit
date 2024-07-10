//
//  RemoveFavoriteUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Combine

protocol RemoveFavoriteUseCase {
    func execute(user: User) -> AnyPublisher<Void, Error>
}
