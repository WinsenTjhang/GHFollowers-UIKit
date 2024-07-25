//
//  SceneDelegate.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 27/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    let dependencyContainer = AppDependencyContainer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupDependencies()
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let tabBarController = UITabBarController()
        window.rootViewController = tabBarController
        
        appCoordinator = AppCoordinator(tabBarController: tabBarController, dependencyContainer: dependencyContainer)
        appCoordinator?.start()
        
        window.makeKeyAndVisible()
    }
    
    private func setupDependencies() {
        // Data Sources
        dependencyContainer.register(NetworkService.self) {URLSessionNetworkService()}
        dependencyContainer.register(FavoritesLocalDataSource.self) {UserDefaultsFavoritesLocalDataSource()}
        
        // Repositories
        dependencyContainer.register(GitHubRepositoryInterface.self) { GitHubRepository(networkService: self.dependencyContainer.resolve()!, imageCache: NSCache<NSString, UIImage>()) }
        dependencyContainer.register(FavoritesRepositoryInterface.self) { FavoritesRepository(localDataSource: self.dependencyContainer.resolve()!) }
        
        // Use Cases
        dependencyContainer.register(FetchFollowersUseCase.self) {FetchFollowersUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
        dependencyContainer.register(FetchUserDetailUseCase.self) {FetchUserDetailUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
        dependencyContainer.register(FetchImageUseCase.self) {FetchImageUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
        dependencyContainer.register(SaveFavoritesUseCase.self) {SaveFavoriteUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
        dependencyContainer.register(RemoveFavoriteUseCase.self) {RemoveFavoriteUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
        dependencyContainer.register(FetchFavoritesUseCase.self) {FetchFavoritesUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
        dependencyContainer.register(ToggleFavoriteUseCase.self) {ToggleFavoriteUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
        dependencyContainer.register(CheckFavoriteStatusUseCase.self) {CheckFavoriteStatusUseCaseImpl(repository: self.dependencyContainer.resolve()!)}
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

