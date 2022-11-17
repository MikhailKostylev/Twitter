//
//  RegisterViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 16.11.2022.
//

import UIKit
import Combine

final class RegisterViewController: UIViewController {
    
    private var viewModel = RegisterViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - UI elements
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.text = R.Text.Register.title
        view.font = R.Font.Register.title
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
            string: R.Text.Register.emailPlaceholder,
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
            string: R.Text.Register.passwordPlaceholder,
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
    
    private let registerButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(R.Text.Register.register, for: .normal)
        view.titleLabel?.font = R.Font.Register.register
        view.tintColor = .white
        view.backgroundColor = R.Color.twitterBlue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = C.registerCornerRadius
        view.isEnabled = false
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupSuperview()
        addSubviews()
        setupLayout()
        addButtonAction()
        addTextFieldsAction()
        setupBindings()
    }
}

// MARK: - Setups

extension RegisterViewController {
    func setupSuperview() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = R.Color.twitterBlue
    }
    
    func addSubviews() {
        [
            titleLabel,
            emailTextField,
            passwordTextField,
            registerButton
        ].forEach { view.addSubview($0) }
    }
    
    func addButtonAction() {
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    func addTextFieldsAction() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
    }
    
    func setupBindings() {
        viewModel.$isRegistrationFormValid.sink { [weak self] validationState in
            self?.registerButton.isEnabled = validationState
        } .store(in: &subscriptions)
        
        viewModel.$user.sink { [weak self] user in
            guard user != nil else { return }
            self?.dismiss(animated: true)
        }.store(in: &subscriptions)
    }
}

// MARK: - Actions

private extension RegisterViewController {
    @objc func didTapRegister() {
        guard registerButton.isEnabled else { return }
        viewModel.createUser()
    }
    
    @objc func didChangeEmailField() {
        viewModel.email = emailTextField.text
        viewModel.validateRegistrationForm()
    }
    
    @objc func didChangePasswordField() {
        viewModel.password = passwordTextField.text
        viewModel.validateRegistrationForm()
    }
    
    @objc func didTapKeyboardDone() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

// MARK: - TextField Delegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapKeyboardDone()
            didTapRegister()
        }
        return true
    }
}

// MARK: - Layout

private extension RegisterViewController {
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
        
        static let registerTop: CGFloat = 30
        static let registerRight: CGFloat = -20
        static let registerMultiplier: CGFloat = 0.5
        static let registerHeight: CGFloat = 50
        static var registerCornerRadius: CGFloat {
            registerHeight / 2
        }
    }
    
    private func setupLayout() {
        [
            titleLabel,
            emailTextField,
            passwordTextField,
            registerButton
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
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: C.registerTop),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.registerRight),
            registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: C.registerMultiplier, constant: C.registerRight),
            registerButton.heightAnchor.constraint(equalToConstant: C.registerHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
