//
//  FavoriteViewController.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 12/07/24.
//

import UIKit
import Combine

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
    }
    
    private func setupUI() {
        titleLabel.text = "Favorites"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    private func setupTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
    }
    
    private func setupBindings() {
        viewModel.$favorites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favorites in
                self?.favoriteTableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
                print("Failed to dequeue FavoriteCell, using default cell")
                return UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
            }
        let favorite = viewModel.favorites[indexPath.row]
        cell.configure(with: favorite, fetchImageUseCase: viewModel.getFetchImageUseCase())
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteToRemove = viewModel.favorites[indexPath.row]
            viewModel.removeFavorite(favoriteToRemove)
        }
    }
}
