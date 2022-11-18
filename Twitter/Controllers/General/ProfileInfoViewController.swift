//
//  ProfileInfoViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 18.11.2022.
//

import UIKit
import PhotosUI

final class ProfileInfoViewController: UIViewController {
    
    // MARK: - Subviews
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.keyboardDismissMode = .interactive
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = R.Text.ProfileInfo.title
        label.textColor = .label
        label.textAlignment = .center
        label.font = R.Font.ProfileInfo.title
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.crop.circle")
        view.tintColor = .secondarySystemBackground
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = C.avatarCornerRadius
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let displayNameTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.returnKeyType = .continue
        view.keyboardType = .default
        view.autocapitalizationType = .words
        view.backgroundColor = .secondarySystemFill
        view.attributedPlaceholder = NSAttributedString(
            string: R.Text.ProfileInfo.displayNamePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
        )
        view.layer.masksToBounds = true
        view.layer.cornerRadius = C.textFieldCornerRadius
        view.leftViewMode = .always
        view.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(
            width: C.textFieldLeftViewSize,
            height: C.textFieldLeftViewSize
        )))
        return view
    }()
    
    private let usernameTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.returnKeyType = .continue
        view.keyboardType = .emailAddress
        view.autocapitalizationType = .none
        view.backgroundColor = .secondarySystemFill
        view.attributedPlaceholder = NSAttributedString(
            string: R.Text.ProfileInfo.usernamePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
        )
        view.layer.masksToBounds = true
        view.layer.cornerRadius = C.textFieldCornerRadius
        view.leftViewMode = .always
        view.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(
            width: C.textFieldLeftViewSize,
            height: C.textFieldLeftViewSize
        )))
        return view
    }()
    
    private let bioTextView: UITextView = {
        let view = UITextView()
        view.textColor = .gray
        view.font = R.Font.ProfileInfo.bio
        view.text = R.Text.ProfileInfo.bioPlaceholder
        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = C.bioCornerRadius
        view.layer.masksToBounds = true
        view.textContainerInset = .init(
            top: C.bioInset,
            left: C.bioInset,
            bottom: C.bioInset,
            right: C.bioInset
        )
        return view
    }()
    
    private let submitButton: UIButton = {
        let view = UIButton(type: .system)
        view.tintColor = .white
        view.setTitle(R.Text.ProfileInfo.submit, for: .normal)
        view.titleLabel?.font = R.Font.ProfileInfo.submit
        view.backgroundColor = R.Color.twitterBlue
        view.layer.cornerRadius = C.submitCornerRadius
        view.layer.masksToBounds = true
        view.isEnabled = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        addSubviews()
        setupDelegated()
        setupLayout()
        addGestureRecognizerToAvatar()
        addSubmitButtonAction()
        hideKeyboardWhenTappedAround()

    }
}

// MARK: - Setups

private extension ProfileInfoViewController {
    func setupVC() {
        view.backgroundColor = .systemBackground
        isModalInPresentation = true
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        [
            titleLabel,
            avatarImageView,
            displayNameTextField,
            usernameTextField,
            bioTextView,
            submitButton
        ].forEach { scrollView.addSubview($0) }
    }
    
    func setupDelegated() {
        displayNameTextField.delegate = self
        usernameTextField.delegate = self
        bioTextView.delegate = self
    }
    
    func addGestureRecognizerToAvatar() {
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUpdateAvatar)))
    }
    
    func addSubmitButtonAction() {
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
    }
}

// MARK: - Actions

private extension ProfileInfoViewController {
    @objc func didTapSubmit() {
        guard submitButton.isEnabled else { return }

    }
    
    @objc func didTapUpdateAvatar() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func didTapKeyboardDone() {
        displayNameTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        bioTextView.resignFirstResponder()
    }
}

// MARK: - Photo Picker Delegate

extension ProfileInfoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.first?.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { [weak self] object, error in
            if let image = object as? UIImage {
                DispatchQueue.main.async {
                    self?.avatarImageView.image  = image
                }
            }
        })
    }
}

// MARK: - TextField Delegate

extension ProfileInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - C.topPadding ), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == displayNameTextField {
            usernameTextField.becomeFirstResponder()
        } else if textField == usernameTextField {
            bioTextView.becomeFirstResponder()
        } else {
            didTapKeyboardDone()
            didTapSubmit()
        }
        return true
    }
}

// MARK: - TextView Delegate

extension ProfileInfoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - C.topPadding ), animated: true)
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        if textView.text.isEmpty {
            textView.text = R.Text.ProfileInfo.bioPlaceholder
            textView.textColor = .gray
        }
    }
}

// MARK: - Layout

private extension ProfileInfoViewController {
    typealias C = Constants
    
    enum Constants {
        static let topPadding: CGFloat = 100
        static let titleTop: CGFloat = 30
        
        static let avatarTop: CGFloat = 30
        static let avatarSize: CGFloat = 120
        static var avatarCornerRadius: CGFloat {
            avatarSize / 2
        }
        
        static let textFieldCornerRadius: CGFloat = 8
        static let textFieldLeftViewSize: CGFloat = 20
        
        static let displayNameTop: CGFloat = 40
        static let displayNameLeft: CGFloat = 20
        static let displayNameRight: CGFloat = -20
        static let displayNameHeight: CGFloat = 50

        static let usernameTop: CGFloat = 20
        
        static let bioTop: CGFloat = 20
        static let bioHeight: CGFloat = 150
        static let bioCornerRadius: CGFloat = 8
        static let bioInset: CGFloat = 15
        
        static let submitLeft: CGFloat = 20
        static let submitRight: CGFloat = -20
        static let submitHeight: CGFloat = 50
        static let submitBottom: CGFloat = -20
        static var submitCornerRadius: CGFloat {
            submitHeight / 2
        }
    }
    
    func setupLayout() {
        [
            scrollView,
            titleLabel,
            avatarImageView,
            displayNameTextField,
            usernameTextField,
            bioTextView,
            submitButton
        ].forEach { $0.prepareForAutoLayout() }
        
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: C.titleTop),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: C.avatarTop),
            avatarImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: C.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: C.avatarSize),
            
            displayNameTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: C.displayNameTop),
            displayNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.displayNameLeft),
            displayNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.displayNameRight),
            displayNameTextField.heightAnchor.constraint(equalToConstant: C.displayNameHeight),
            
            usernameTextField.topAnchor.constraint(equalTo: displayNameTextField.bottomAnchor, constant: C.usernameTop),
            usernameTextField.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalTo: displayNameTextField.heightAnchor),
            
            bioTextView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: C.bioTop),
            bioTextView.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            bioTextView.heightAnchor.constraint(equalToConstant: C.bioHeight),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.submitLeft),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.submitRight),
            submitButton.heightAnchor.constraint(equalToConstant: C.submitHeight),
            submitButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: C.submitBottom)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
