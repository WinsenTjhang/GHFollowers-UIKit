//
//  UserInfoViewController.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 22/07/24.
//

import UIKit
import Combine
import SafariServices

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var repoContainerView: UIView!
    @IBOutlet weak var publicRepos: UILabel!
    @IBOutlet weak var publicGists: UILabel!
    @IBOutlet weak var gitHubProfileButton: UIButton!
    
    @IBOutlet weak var followerContainerView: UIView!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var getFollowersButton: UIButton!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    var viewModel: UserInfoViewModel!
    private var cancellables = Set<AnyCancellable>()
    var coordinator: SearchCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureUI()
    }
    
    private func configureUI() {
        avatarImageView.layer.cornerRadius = 10
        gitHubProfileButton.layer.cornerRadius = 10
        getFollowersButton.layer.cornerRadius = 10
        repoContainerView.layer.cornerRadius = 10
        followerContainerView.layer.cornerRadius = 10
    }
    
    private func bindViewModel() {
        viewModel.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.usernameLabel.text = user?.login
                self?.fullnameLabel.text = user?.name
                self?.locationLabel.text = user?.location
                self?.publicRepos.text = String(user?.publicRepos ?? 0)
                self?.publicGists.text = String(user?.publicGists ?? 0)
                self?.followers.text = String(user?.followers ?? 0)
                self?.following.text = String(user?.following ?? 0)
                self?.createdAtLabel.text = "GitHub since \(DateFormatter.monthYearDateFormatter.string(from: user?.createdAt ?? Date()))"
                
                if let bio = user?.bio, !bio.isEmpty {
                    self?.bioLabel.text = bio
                    self?.bioLabel.isHidden = false
                } else {
                    self?.bioLabel.isHidden = true
                }
            }
            .store(in: &cancellables)
        
        viewModel.$avatarImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.avatarImageView.image = image
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
    
    @IBAction func openGitHubProfile(_ sender: UIButton) {
        guard let url = URL(string: viewModel.user!.htmlUrl) else {
                print("Invalid URL")
                return
            }
            
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    
    @IBAction func getFollowers(_ sender: UIButton) {
        coordinator?.navigateToFollowerListView(viewModel.username)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
