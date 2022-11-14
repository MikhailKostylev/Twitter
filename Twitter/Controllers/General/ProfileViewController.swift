//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 14.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
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
        setupSubviews()
    }
}

// MARK: - Setups

private extension ProfileViewController {
    func setupSuperview() {
        view.backgroundColor = .systemBackground
        navigationItem.title = R.Text.Person.title
    }
    
    func setupTableView() {
        tableView.tableHeaderView = createHeaderView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            TweetTableViewCell.self,
            forCellReuseIdentifier: TweetTableViewCell.id
        )
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        setupLayout()
    }
    
    func createHeaderView() -> UIView {
        ProfileTableViewHeader(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: view.width, height: Constants.profileHeaderHeight)
            )
        )
    }
}

// MARK: - Table DataSource

extension ProfileViewController: UITableViewDataSource {
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

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Tweet Cell Delegate

extension ProfileViewController: TweetTableViewCellDelegate {
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

private extension ProfileViewController {
    enum Constants {
        static let logoSize: CGFloat = 36
        static let profileHeaderHeight: CGFloat = 400
    }
    
    func setupLayout() {
        tableView.prepareForAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
