//
//  HomeViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 12.11.2022.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private var viewModel = HomeViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Subviews
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var composeTweetButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction { [weak self] _ in
            self?.navigateToTweetComposer()
        })
        button.backgroundColor = R.Color.twitterBlue
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
        button.layer.cornerRadius = C.composeTweetButtonCornerRadius
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperview()
        setupTableView()
        addSubviews()
        setupLayout()
        setupNavigationBar()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveUser()
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
        view.addSubview(composeTweetButton)
    }
    
    func setupNavigationBar() {
        setupTitleView()
        setupProfileBarButton()
        setupLogOutBarButton()
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
    
    func setupLogOutBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain,
            target: self,
            action: #selector(didTapLogOut)
        )
    }
    
    func setupBindings() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
            }
        }.store(in: &subscriptions)
    }
    
    func completeUserOnboarding() {
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
    }
}

// MARK: - Actions

private extension HomeViewController {
    @objc func didTapProfile() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapLogOut() {
        HapticsManager.shared.vibrate(for: .warning)
        presentActionSheetAlert()
    }
    
    func retrieveUser() {
        viewModel.retrieveUser()
    }
    
    func navigateToTweetComposer() {
        let vc = UINavigationController(rootViewController: TweetComposeViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - Log Out

private extension HomeViewController {
    func presentActionSheetAlert() {
        let actionSheet = UIAlertController(
            title: R.Text.Home.actionSheetTitle,
            message: R.Text.Home.actionSheetMessage,
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(title: R.Text.Home.cancel, style: .cancel))
        actionSheet.addAction(UIAlertAction(title: R.Text.Home.destructive, style: .destructive) { [weak self] _ in
            self?.logOut()
        })
        
        present(actionSheet, animated: true)
    }
    
    func logOut() {
        AuthManager.shared.logOut { [weak self] success in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if success {
                    HapticsManager.shared.vibrate(for: .success)
                    self.resetNavigation()
                    self.presentOnboarding()
                } else {
                    HapticsManager.shared.vibrate(for: .error)
                    self.failedToLogOut()
                }
            }
        }
    }
    
    func resetNavigation() {
        navigationController?.popToRootViewController(animated: false)
        tabBarController?.selectedIndex = 0
    }
    
    func presentOnboarding() {
        let vc = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func failedToLogOut() {
        presentAlert(
            title: R.Text.Home.alertTitle,
            message: R.Text.Home.alertMessage
        )
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
    typealias C = Constants
    
    enum Constants {
        static let logoSize: CGFloat = 36
        static let composeTweetRight: CGFloat = -25
        static let composeTweetBottom: CGFloat = -120
        static let composeTweetSize: CGFloat = 60
        static var composeTweetButtonCornerRadius: CGFloat {
            composeTweetSize / 2
        }
    }
    
    func setupLayout() {
        tableView.prepareForAutoLayout()
        composeTweetButton.prepareForAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            composeTweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.composeTweetRight),
            composeTweetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: C.composeTweetBottom),
            composeTweetButton.widthAnchor.constraint(equalToConstant: C.composeTweetSize),
            composeTweetButton.heightAnchor.constraint(equalToConstant: C.composeTweetSize)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
