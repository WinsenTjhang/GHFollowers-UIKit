//
//  CheckFavoriteStatusUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 16/07/24.
//

import Combine

protocol CheckFavoriteStatusUseCase {
    func execute(user: User) -> AnyPublisher<Bool, Error>
}
