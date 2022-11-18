//
//  LoginViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 17.11.2022.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    private var viewModel = AuthenticationViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.text = R.Text.Login.title
        view.font = R.Font.Login.title
        view.textColor = .label
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.returnKeyType = .continue
        view.keyboardType = .emailAddress
        view.autocapitalizationType = .none
        view.backgroundColor = .secondarySystemBackground
        view.attributedPlaceholder = NSAttributedString(
            string: R.Text.Login.emailPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
        )
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = C.textFieldCornerRadius
        view.layer.borderWidth = C.textFieldBorderWidth
        view.layer.borderColor = UIColor.gray.cgColor
        view.leftViewMode = .always
        view.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(
            width: C.textFieldLeftViewWidth,
            height: C.textFieldLeftViewHeight
        )))
        view.delegate = self
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.textContentType  = .oneTimeCode
        view.returnKeyType = .done
        view.keyboardType = .default
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.attributedPlaceholder = NSAttributedString(
            string: R.Text.Login.passwordPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
        )
        view.isSecureTextEntry = true
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = C.textFieldCornerRadius
        view.layer.borderWidth = C.textFieldBorderWidth
        view.layer.borderColor = UIColor.gray.cgColor
        view.leftViewMode = .always
        view.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(
            width: C.textFieldLeftViewWidth,
            height: C.textFieldLeftViewHeight
        )))
        view.delegate = self
        return view
    }()
    
    private let loginButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(R.Text.Login.login, for: .normal)
        view.titleLabel?.font = R.Font.Login.login
        view.tintColor = .white
        view.backgroundColor = R.Color.twitterBlue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = C.loginCornerRadius
        view.isEnabled = false
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperview()
        addSubviews()
        setupLayout()
        setupBindings()
        addButtonAction()
        addTextFieldsAction()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - Setups

extension LoginViewController {
    func setupSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    func addSubviews() {
        [
            titleLabel,
            emailTextField,
            passwordTextField,
            loginButton
        ].forEach { view.addSubview($0) }
    }
    
    func addButtonAction() {
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    func addTextFieldsAction() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
    }
    
    func setupBindings() {
        viewModel.$isAuthenticationFormValid.sink { [weak self] validationState in
            self?.loginButton.isEnabled = validationState
        } .store(in: &subscriptions)
        
        viewModel.$user.sink { [weak self] user in
            guard user != nil else { return }
            self?.dismiss(animated: true)
        }.store(in: &subscriptions)
        
        viewModel.$error.sink { [weak self] errorString in
            guard let error = errorString else { return }
            self?.failedToLogin(with: error)
        }.store(in: &subscriptions)
    }
}

// MARK: - Actions

private extension LoginViewController {
    @objc func didTapLogin() {
        guard loginButton.isEnabled else { return }
        viewModel.loginUser()
    }
    
    @objc func didChangeEmailField() {
        viewModel.email = emailTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc func didChangePasswordField() {
        viewModel.password = passwordTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc func didTapKeyboardDone() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func failedToLogin(with error: String) {
        presentAlert(title: R.Text.Login.error, message: error)
    }
}

// MARK: - TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapKeyboardDone()
            didTapLogin()
        }
        return true
    }
}

// MARK: - Layout

private extension LoginViewController {
    typealias C = Constants
    
    enum Constants {
        static let titleTop: CGFloat = 20
        
        static let emailTop: CGFloat = 30
        static let emailLeft: CGFloat = 20
        static let emailRight: CGFloat = -20
        static let emailHeight: CGFloat = 60
        
        static let textFieldLeftViewWidth: CGFloat = 30
        static let textFieldLeftViewHeight: CGFloat = 60
        static let textFieldBorderWidth: CGFloat = 1
        static var textFieldCornerRadius: CGFloat {
            emailHeight / 2
        }
        
        static let passwordTop: CGFloat = 20
        
        static let loginTop: CGFloat = 30
        static let loginRight: CGFloat = -20
        static let loginMultiplier: CGFloat = 0.5
        static let loginHeight: CGFloat = 50
        static var loginCornerRadius: CGFloat {
            loginHeight / 2
        }
    }
    
    private func setupLayout() {
        [
            titleLabel,
            emailTextField,
            passwordTextField,
            loginButton
        ].forEach { $0.prepareForAutoLayout() }
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: C.titleTop),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: C.emailTop),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.emailLeft),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.emailRight),
            emailTextField.heightAnchor.constraint(equalToConstant: C.emailHeight),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: C.passwordTop),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: C.loginTop),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.loginRight),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: C.loginMultiplier, constant: C.loginRight),
            loginButton.heightAnchor.constraint(equalToConstant: C.loginHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
