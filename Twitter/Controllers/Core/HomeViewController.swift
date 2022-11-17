//
//  HomeViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 12.11.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - UI elements
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperview()
        setupTableView()
        addSubviews()
        setupLayout()
        setupNavigationBar()
    }
}

// MARK: - Setups

private extension HomeViewController {
    func setupSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            TweetTableViewCell.self,
            forCellReuseIdentifier: TweetTableViewCell.id
        )
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setupNavigationBar() {
        setupTitleView()
        setupProfileBarButton()
    }
    
    func setupTitleView() {
        let logoImageView = UIImageView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: Constants.logoSize, height: Constants.logoSize)
            )
        )
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = R.Image.Home.twitterLogoMedium?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = R.Color.twitterBlue
        
        let titleView = UIView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: Constants.logoSize, height: Constants.logoSize)
            )
        )
        titleView.addSubview(logoImageView)
        navigationItem.titleView = titleView
    }
    
    func setupProfileBarButton() {
        let profileImage = UIImage(systemName: "person.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: profileImage,
            style: .plain,
            target: self,
            action: #selector(didTapProfile)
        )
    }
}

// MARK: - Actions

private extension HomeViewController {
    @objc func didTapProfile() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Table DataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TweetTableViewCell.id,
            for: indexPath
        ) as? TweetTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
}

// MARK: - Table Delegate

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Tweet Cell Delegate

extension HomeViewController: TweetTableViewCellDelegate {
    func tweetCellDidTapReply() {
        print(#function)
    }
    
    func tweetCellDidTapRetweet() {
        print(#function)
    }
    
    func tweetCellDidTapLike() {
        print(#function)
    }
    
    func tweetCellDidTapShare() {
        print(#function)
    }
}

// MARK: - Layout

private extension HomeViewController {
    enum Constants {
        static let logoSize: CGFloat = 36
    }
    
    func setupLayout() {
        tableView.prepareForAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
