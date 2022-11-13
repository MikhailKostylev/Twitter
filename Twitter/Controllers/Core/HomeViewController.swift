//
//  HomeViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 12.11.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    enum Constants {
        static let dividerHeight: CGFloat = 1
        static let logoSize: CGFloat = 36
    }
    
    // MARK: - UI elements
    
    private let timelineTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperview()
        setupTableView()
        setupSubviews()
        setupNavigationBar()
    }
}

// MARK: - Setups

extension HomeViewController {
    private func setupSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        timelineTableView.register(
            TweetTableViewCell.self,
            forCellReuseIdentifier: TweetTableViewCell.id
        )
    }
    
    private func setupSubviews() {
        view.addSubview(divider)
        view.addSubview(timelineTableView)
        setupLayout()
    }
    
    private func setupNavigationBar() {
        setupTitleView()
        setupProfileBarButton()
    }
    
    private func setupTitleView() {
        let logoImageView = UIImageView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: Constants.logoSize, height: Constants.logoSize)
            )
        )
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = R.Image.Home.twitterLogoMedium?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = R.Color.twitter
        
        let titleView = UIView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: Constants.logoSize, height: Constants.logoSize)
            )
        )
        titleView.addSubview(logoImageView)
        navigationItem.titleView = titleView
    }
    
    private func setupProfileBarButton() {
        let profileImage = UIImage(systemName: "person")
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
    func setupLayout() {
        divider.prepareForAutoLayout()
        timelineTableView.prepareForAutoLayout()
        
        let constraints = [
            divider.heightAnchor.constraint(equalToConstant: Constants.dividerHeight),
            divider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            timelineTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timelineTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timelineTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            timelineTableView.bottomAnchor.constraint(equalTo: divider.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
