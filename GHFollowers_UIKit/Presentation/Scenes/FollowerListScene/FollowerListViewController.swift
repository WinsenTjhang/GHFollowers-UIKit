//
//  FollowerListViewController.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 15/07/24.
//

import UIKit
import Combine

class FollowerListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: FollowerListViewModel!
    var coordinator: UserInfoShowingCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        bindViewModel()
    }
    
    private func configureViewController() {
        navigationItem.title = viewModel.username
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func favoriteButtonTapped() {
        viewModel.toggleFavorite()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FollowerCell", bundle: nil), forCellWithReuseIdentifier: "FollowerCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
    }
    
    private func bindViewModel() {
        viewModel.$followers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFavorite in
                let imageName = isFavorite ? "heart.fill" : "heart"
                self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
            }
            .store(in: &cancellables)
    }
    
    
    
}

extension FollowerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowerCell", for: indexPath) as! FollowerCell
        let follower = viewModel.followers[indexPath.item]
        cell.configure(with: follower, fetchImageUseCase: viewModel.fetchImageUseCase)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.getNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = viewModel.followers[indexPath.item]
        coordinator?.showUserInfo(for: user.login)
    }
    
}

extension FollowerListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 2 // Total horizontal padding
        let minimumItemSpacing: CGFloat = 1 // Minimum spacing between items
        let availableWidth = collectionView.bounds.width - padding
        let itemWidth = (availableWidth - minimumItemSpacing * 2) / 3 // 3 columns
        return CGSize(width: itemWidth, height: itemWidth + 15) // Adjust height as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1) // Adjust these values for overall section insets
    }
}
