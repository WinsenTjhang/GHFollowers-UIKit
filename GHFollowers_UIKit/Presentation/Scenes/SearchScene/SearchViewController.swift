//
//  ViewController.swift
//  GHFollowers_UIKit
//
//  Created by winsen on 27/05/24.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var viewModel: SearchViewModel!
    var coordinator: SearchCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        usernameTextField.delegate = self
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        searchButton.layer.cornerRadius = 10
        updateSearchButtonState()
    }
    
    @objc private func textFieldDidChange() {
        updateSearchButtonState()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !username.isEmpty else { return }
        navigateToFollowerList(for: username)
    }
    
    private func updateSearchButtonState() {
        let text = usernameTextField.text ?? ""
        searchButton.isEnabled = viewModel.isSearchEnabled(for: text)
    }
    
    private func navigateToFollowerList(for username: String) {
        coordinator.navigateToFollowerListView(username)
    }
}



