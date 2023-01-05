//
//  TweetComposeViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 05.01.2023.
//

import UIKit

final class TweetComposeViewController: UIViewController {
    
    // MARK: - Subviews
    
    private let tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = R.Color.twitterBlue
        button.setTitle(R.Text.TweetCompose.tweet, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = R.Font.TweetCompose.tweetButton
        button.layer.cornerRadius = C.tweetButtonCornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var tweetContentTextView: UITextView = {
        let view = UITextView()
        view.textColor = .gray
        view.font = R.Font.TweetCompose.tweetContent
        view.text = R.Text.TweetCompose.contentPlaceholder
        view.textContainerInset = .init(
            top: C.tweetContentTextViewInset,
            left: C.tweetContentTextViewInset,
            bottom: C.tweetContentTextViewInset,
            right: C.tweetContentTextViewInset
        )
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupCancelBarButton()
        addSubviews()
        setupLayout()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - Setups

private extension TweetComposeViewController {
    func setupVC() {
        view.backgroundColor = .systemBackground
        title = R.Text.TweetCompose.tweet
    }
    
    func setupCancelBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: R.Text.TweetCompose.cancel,
            style: .plain,
            target: self,
            action: #selector(didTapCancel)
        )
        navigationItem.leftBarButtonItem?.tintColor = R.Color.twitterBlue
    }
    
    func addSubviews() {
        view.addSubview(tweetButton)
        view.addSubview(tweetContentTextView)
    }
}

// MARK: - Actions

private extension TweetComposeViewController {
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
}

// MARK: - TextView Delegate

extension TweetComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = R.Text.TweetCompose.contentPlaceholder
            textView.textColor = .gray
        }
    }
}

// MARK: - Layout

private extension TweetComposeViewController {
    typealias C = Constants
    
    enum Constants {
        static let tweetContentTextViewInset: CGFloat = 15
        static let tweetButtonRight: CGFloat = -10
        static let tweetButtonBottom: CGFloat = -10
        static let tweetButtonWidth: CGFloat = 120
        static let tweetButtonHeight: CGFloat = 50
        static var tweetButtonCornerRadius: CGFloat {
            tweetButtonHeight / 2
        }
        
        static let tweetContentLeft: CGFloat = 15
        static let tweetContentRight: CGFloat = -15
        static let tweetContentBottom: CGFloat = -10
    }
    
    func setupLayout() {
        tweetButton.prepareForAutoLayout()
        tweetContentTextView.prepareForAutoLayout()
        
        let constraints = [
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.tweetButtonRight),
            tweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: C.tweetButtonBottom),
            tweetButton.widthAnchor.constraint(equalToConstant: C.tweetButtonWidth),
            tweetButton.heightAnchor.constraint(equalToConstant: C.tweetButtonHeight),
            
            tweetContentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetContentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: C.tweetContentLeft),
            tweetContentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: C.tweetContentRight),
            tweetContentTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor, constant: C.tweetContentBottom)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
