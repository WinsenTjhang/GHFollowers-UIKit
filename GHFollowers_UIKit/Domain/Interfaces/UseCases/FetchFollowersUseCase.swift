//
//  FetchFollowersUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Foundation
import Combine

protocol FetchFollowersUseCase {
    func execute(for username: String, page: Int) -> AnyPublisher<[User], Error>
}
