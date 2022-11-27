//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 14.11.2022.
//

import UIKit
import Combine
import SDWebImage

final class ProfileViewController: UIViewController {
    
    private let viewModel = ProfileViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    private var isStatusBarHidden = true
    
    // MARK: - Subviews
    
    private let statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.alpha = 0
        return view
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private var tableHeaderView: ProfileTableViewHeader?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperview()
        setupTableView()
        addSubviews()
        setupLayout()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
        getUserData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavBar()
    }
}

// MARK: - Setups

private extension ProfileViewController {
    func setupSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    func setupTableView() {
        createTableHeaderView()
        tableView.tableHeaderView = tableHeaderView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            TweetTableViewCell.self,
            forCellReuseIdentifier: TweetTableViewCell.id
        )
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(statusBar)
    }
    
    func createTableHeaderView() {
        tableHeaderView = ProfileTableViewHeader(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: view.width, height: C.profileHeaderHeight)
            ),
            headerImageHeight: C.profileHeaderImageHeight
        )
    }
    
    func setupBindings() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            self?.fillProfileInfo(user: user)
        }.store(in: &subscriptions)
    }
    
    func fillProfileInfo(user: TwitterUser) {
        self.tableHeaderView?.displayNameLabel.text = user.displayName
        self.tableHeaderView?.usernameLabel.text = "@\(user.username)"
        self.tableHeaderView?.locationLabel.text = user.location
        self.tableHeaderView?.userBioLabel.text = user.bio
        self.tableHeaderView?.followersCountLabel.text = "\(user.followersCount)"
        self.tableHeaderView?.followingCountLabel.text = "\(user.followingCount)"
        self.tableHeaderView?.avatarImageView.sd_setImage(with: URL(string: user.avatarPath))
    }
    
    func getUserData() {
        viewModel.retrieveUser()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        if yPosition > C.profileHeaderImageHeight && isStatusBarHidden {
            isStatusBarHidden = false
            showStatusBar()
            
        } else if yPosition < C.profileHeaderImageHeight && !isStatusBarHidden {
            isStatusBarHidden = true
            hideStatusBar()
        }
    }
}

// MARK: - Actions

private extension ProfileViewController {
    func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func showNavBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    func hideStatusBar() {
        UIView.animate(withDuration: 0.3, delay: 0,options: .curveLinear) {
            self.statusBar.alpha = 0
        }
    }
    
    func showStatusBar() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            self.statusBar.alpha = 1
        }
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
    typealias C = Constants
    
    enum Constants {
        static let profileHeaderHeight: CGFloat = 425
        static let profileHeaderImageHeight: CGFloat = 150
    }
    
    func setupLayout() {
        tableView.prepareForAutoLayout()
        statusBar.prepareForAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
