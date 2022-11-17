//
//  OnboardingViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 16.11.2022.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - UI elements
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.Image.Onboarding.logo
        view.contentMode = .scaleAspectFit
        view.tintColor = R.Color.twitterBlue
        return view
    }()
    
    private let welcomeLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.text = R.Text.Onboarding.welcome
        view.font = R.Font.Onboarding.welcome
        view.textColor = .label
        return view
    }()
    
    private let createAccountButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(R.Text.Onboarding.createAccount, for: .normal)
        view.titleLabel?.font = R.Font.Onboarding.createAccount
        view.backgroundColor = R.Color.twitterBlue
        view.tintColor = .white
        view.layer.cornerRadius = C.createAccountCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let loginLabel: UILabel = {
        let view = UILabel()
        view.text = R.Text.Onboarding.loginLabel
        view.font = R.Font.Onboarding.loginLabel
        view.tintColor = .gray
        return view
    }()
    
    private let loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(R.Text.Onboarding.loginButton, for: .normal)
        view.titleLabel?.font = R.Font.Onboarding.loginButton
        view.tintColor = R.Color.twitterBlue
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperview()
        addSubviews()
        setupLayout()
        addButtonActions()
    }
}

// MARK: - Setups

private extension OnboardingViewController {
    func setupSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    func addSubviews() {
        [
            logoImageView,
            welcomeLabel,
            createAccountButton,
            loginLabel,
            loginButton
        ].forEach { view.addSubview($0) }
    }
    
    func addButtonActions() {
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
}

// MARK: - Actions

private extension OnboardingViewController {
    @objc func didTapCreateAccount() {
        let vc = RegisterViewController()
        setupAndPush(viewController: vc)
    }
    
    @objc private func didTapLogin() {
        let vc = LoginViewController()
        setupAndPush(viewController: vc)
    }
    
    func setupAndPush(viewController vc: UIViewController) {
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = R.Color.twitterBlue
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Layout

private extension OnboardingViewController {
    typealias C = Constants
    
    enum Constants {
        static let logoTop: CGFloat = 20
        static let logoSize: CGFloat = 200
        
        static let welcomeLeft: CGFloat = 20
        static let welcomeRight: CGFloat = -20
        
        static let createAccountTop: CGFloat = 20
        static let createAccountWidth: CGFloat = -20
        static let createAccountHeight: CGFloat = 60
        static var createAccountCornerRadius: CGFloat {
            createAccountHeight / 2
        }
        
        static let loginLabelLeft: CGFloat = 20
        static let loginLabelBottom: CGFloat = -20
        
        static let loginButtonLeft: CGFloat = 10
    }
    
    func setupLayout() {
        [
            logoImageView,
            welcomeLabel,
            createAccountButton,
            loginLabel,
            loginButton
        ].forEach { $0.prepareForAutoLayout() }
        
        let constraints = [
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: C.logoTop),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: C.logoSize),
            logoImageView.heightAnchor.constraint(equalToConstant: C.logoSize),
            
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.welcomeLeft),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.welcomeRight),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: C.createAccountCornerRadius),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: C.createAccountWidth),
            createAccountButton.heightAnchor.constraint(equalToConstant: C.createAccountHeight),
            
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.loginLabelLeft),
            loginLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: C.loginLabelBottom),
            
            loginButton.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: C.loginButtonLeft),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
