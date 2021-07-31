//
//  ProfileViewController.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 29.7.21..
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    private var models = [String]()
    private var profileImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        getUserProfile()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func getUserProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.updateUI(with: model)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.failedToGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        // Configure table view models
        models.append("Full Name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
    }

    private func failedToGetProfile() {
        let label = UILabel()
        label.text = "Failed to load profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        label.center = view.center
        view.addSubview(label)
    }
    
    private func createTableHeader(with string: String?) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width / 1.5))
        let imageSize: CGFloat = headerView.height / 2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        imageView.layer.borderWidth = 5
        
        changeImageBorderColor(imageView: imageView)
        
        if string != nil {
            guard let urlString = string, let url = URL(string: urlString) else { return }
            imageView.sd_setImage(with: url, completed: nil)
        } else {
            imageView.image = UIImage(named: "test")
            imageView.tintColor = .label
        }
        
        self.profileImageView = imageView
        tableView.tableHeaderView = headerView
    }
    
    /// Changes profile images border color by checking if dark mode is turned on or not
    private func changeImageBorderColor(imageView: UIImageView) {
        switch traitCollection.userInterfaceStyle {
        case .light:
            imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .dark:
            imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        default:
            imageView.layer.borderColor = nil
        }
    }
    
    /// Registes when there is a change with dark mode and calls our function to chande the profileImageViews border color
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let defImageView = UIImageView(image: UIImage(systemName: "person.circle"))
        changeImageBorderColor(imageView: profileImageView ?? defImageView)
    }
    
}

//MARK: - UITableViewDataSource_Delegate

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
