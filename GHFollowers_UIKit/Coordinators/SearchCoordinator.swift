//
//  SearchCoordinator.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 12/07/24.
//

import UIKit

class SearchCoordinator: UserInfoShowingCoordinator {
    var navigationController: UINavigationController
    var dependencyContainer: DependencyContainer
    
    init(dependencyContainer: DependencyContainer) {
        self.navigationController = UINavigationController()
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        guard let searchVC = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            fatalError("Unable to instantiate SearchViewController from storyboard.")
        }
        
        let viewModel = SearchViewModel()
        searchVC.viewModel = viewModel
        searchVC.coordinator = self
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([searchVC], animated: false)
    }
    
    func navigateToFollowerListView(_ username: String) {
        guard let followerListVC = UIStoryboard(name: "FollowerListViewController", bundle: nil).instantiateViewController(withIdentifier: "FollowerListViewController") as? FollowerListViewController else {
            print("FollowerListViewController instantiation failed")
            return
        }
        
        let viewModel = FollowerListViewModel(username: username,
                                              fetchFollowersUseCase: dependencyContainer.resolve()!,
                                              toggleFavoriteUseCase: dependencyContainer.resolve()!,
                                              checkFavoriteStatusUseCase: dependencyContainer.resolve()!,
                                              fetchImageUseCase: dependencyContainer.resolve()!,
                                              fetchUserDetailUseCase: dependencyContainer.resolve()!)
        
        followerListVC.viewModel = viewModel
        followerListVC.coordinator = self
        
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(followerListVC, animated: true)
    }
    
    func showUserInfo(for username: String) {
        guard let userInfoVC = UIStoryboard(name: "UserInfoViewController", bundle: nil).instantiateViewController(withIdentifier: "UserInfoViewController") as? UserInfoViewController else {
            print("FollowerListViewController instantiation failed")
            return
        }
        
        let userInfoViewModel = UserInfoViewModel(fetchUserDetailUseCase: dependencyContainer.resolve()!, fetchImageUseCase: dependencyContainer.resolve()!, username: username)
        userInfoVC.viewModel = userInfoViewModel
        userInfoVC.coordinator = self
        
        navigationController.pushViewController(userInfoVC, animated: true)
    }
}
