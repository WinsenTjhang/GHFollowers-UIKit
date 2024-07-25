//
//  FetchImageUseCase.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import UIKit
import Combine

protocol FetchImageUseCase {
    func execute(from url: String) -> AnyPublisher<UIImage, Error>
}
