//
//  SearchViewModel.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 11/07/24.
//

import Foundation

class SearchViewModel {
    func isSearchEnabled(for text: String) -> Bool {
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
