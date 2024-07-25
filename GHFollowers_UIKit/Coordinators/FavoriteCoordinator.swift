//
//  FavoriteCoordinator.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 12/07/24.
//

import UIKit

class FavoriteCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let dependencyContainer: DependencyContainer
    
    init(dependencyContainer: DependencyContainer) {
        self.navigationController = UINavigationController()
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        guard let favoriteVC = UIStoryboard(name: "FavoriteViewController", bundle: nil).instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController else {
            fatalError("Unable to instantiate FavoriteViewController from storyboard.")
        }
        
        let viewModel = FavoriteViewModel(fetchFavoritesUseCase: dependencyContainer.resolve()!, removeFavoriteUseCase: dependencyContainer.resolve()!, fetchImageUseCase: dependencyContainer.resolve()!)
        favoriteVC.viewModel = viewModel
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([favoriteVC], animated: false)
    }
}
