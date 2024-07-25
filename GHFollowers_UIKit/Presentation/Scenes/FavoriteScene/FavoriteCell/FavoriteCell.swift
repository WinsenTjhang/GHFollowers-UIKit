//
//  FavoriteCell.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 18/07/24.
//

import UIKit
import Combine

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    private var cancellable: AnyCancellable?
    private var fetchImageUseCase: FetchImageUseCase?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable?.cancel()
        avatarImageView.image = nil
    }
    
    func configure(with follower: User, fetchImageUseCase: FetchImageUseCase) {
        self.fetchImageUseCase = fetchImageUseCase
        usernameLabel.text = follower.login
        loadImage(from: follower.avatarUrl)
    }
    
    private func loadImage(from url: String) {
        cancellable = fetchImageUseCase?.execute(from: url)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.avatarImageView.image = UIImage(systemName: "person.circle")
                    }
                },
                receiveValue: { [weak self] image in
                    self?.avatarImageView.image = image
                }
            )
    }
}
