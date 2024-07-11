//
//  NetworkService.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 10/07/24.
//

import Foundation
import Combine

protocol NetworkService {
    func get(url: String) -> AnyPublisher<Data, Error>
    func getData(url: String) -> AnyPublisher<Data, Error>
}

class URLSessionNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(url: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func getData(url: String) -> AnyPublisher<Data, Error> {
        get(url: url)
    }
}
