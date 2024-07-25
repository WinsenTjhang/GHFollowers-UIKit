//
//  AppCoordinator.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 09/07/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}

protocol AppCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get }
    var childCoordinators: [Coordinator] { get }
}

protocol UserInfoShowingCoordinator: Coordinator {
    func showUserInfo(for username: String)
}

class AppCoordinator: AppCoordinatorProtocol {
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    let dependencyContainer: DependencyContainer
    var navigationController: UINavigationController {
            return tabBarController.selectedViewController as! UINavigationController
        }
    
    init(tabBarController: UITabBarController, dependencyContainer: DependencyContainer) {
        self.tabBarController = tabBarController
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let searchCoordinator = SearchCoordinator(dependencyContainer: dependencyContainer)
        let favoriteCoordinator = FavoriteCoordinator(dependencyContainer: dependencyContainer)
        
        childCoordinators = [searchCoordinator, favoriteCoordinator]
        
        searchCoordinator.start()
        favoriteCoordinator.start()
        
        tabBarController.viewControllers = [
            searchCoordinator.navigationController,
            favoriteCoordinator.navigationController
        ]
        
        searchCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        favoriteCoordinator.navigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        navigateToSearch()
        
    }
    
    private func navigateToSearch() {
        tabBarController.selectedIndex = 0
    }
    
    
    
}
