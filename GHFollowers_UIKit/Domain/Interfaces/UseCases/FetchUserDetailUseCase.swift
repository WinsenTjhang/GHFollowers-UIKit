//
//  FetchUserDetailUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Foundation
import Combine

protocol FetchUserDetailUseCase {
    func execute(for username: String) -> AnyPublisher<User, Error>
}
