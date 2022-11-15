//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 13.11.2022.
//

import UIKit

protocol TweetTableViewCellDelegate: AnyObject {
    func tweetCellDidTapReply()
    func tweetCellDidTapRetweet()
    func tweetCellDidTapLike()
    func tweetCellDidTapShare()
}

final class TweetTableViewCell: UITableViewCell {
    static let id = String(describing: TweetTableViewCell.self)
    
    weak var delegate: TweetTableViewCellDelegate?
    
    // MARK: - UI elements
    
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.Image.Home.tweetCellAvatar
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = Constants.avatarCornerRadius
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let displayNameLabel: UILabel = {
        let view = UILabel()
        view.text = "DisplayName"
        view.numberOfLines = 1
        view.textColor = .label
        view.textAlignment = .left
        view.font = R.Font.TweetCell.displayName
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let view = UILabel()
        view.text = "@username"
        view.numberOfLines = 1
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.font = R.Font.TweetCell.username
        return view
    }()
    
    private let textContentLabel: UILabel = {
        let view = UILabel()
        view.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 😉"
        view.numberOfLines = 0
        view.textColor = .label
        view.textAlignment = .natural
        return view
    }()
    
    private let replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.Image.Home.tweetCellReply, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.Image.Home.tweetCellRetweet, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.Image.Home.tweetCellLike, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.Image.Home.tweetCellShare, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        addSubviews()
        setupLayout()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
}

// MARK: - Setups

private extension TweetTableViewCell {
    func setupContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
    }
    
    func addSubviews() {
        [
            avatarImageView,
            displayNameLabel,
            usernameLabel,
            textContentLabel,
            replyButton,
            retweetButton,
            likeButton,
            shareButton
        ].forEach { contentView.addSubview($0) }
    }
    
    func setupButtonActions() {
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
}

// MARK: - Actions

private extension TweetTableViewCell {
    @objc func didTapReply() {
        delegate?.tweetCellDidTapReply()
    }
    
    @objc func didTapRetweet() {
        delegate?.tweetCellDidTapRetweet()
    }
    
    @objc func didTapLike() {
        delegate?.tweetCellDidTapLike()
    }
    
    @objc func didTapShare() {
        delegate?.tweetCellDidTapShare()
    }
}

// MARK: - Layout

private extension TweetTableViewCell {
    typealias C = Constants
    
    enum Constants {
        static let avatarTopPadding: CGFloat = 15
        static let avatarLeftPadding: CGFloat = 20
        static let avatarSize: CGFloat = 50
        static var avatarCornerRadius: CGFloat {
            avatarSize / 2
        }
        
        static let displayNameTop: CGFloat = 15
        static let displayNameLeft: CGFloat = 10
        
        static let usernameLeft: CGFloat = 5
        static let usernameRight: CGFloat = -10
        
        static let textContentTop: CGFloat = 5
        static let textContentRight: CGFloat = -20
        
        static let replyTop: CGFloat = 10
        static let replyBottom: CGFloat = -15
        
        static let buttonSpacing: CGFloat = 50
    }
    
    func setupLayout() {
        [
            avatarImageView,
            displayNameLabel,
            usernameLabel,
            textContentLabel,
            replyButton,
            retweetButton,
            likeButton,
            shareButton
        ].forEach { $0.prepareForAutoLayout() }
        
        let constraints = [
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: C.avatarTopPadding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: C.avatarLeftPadding),
            avatarImageView.widthAnchor.constraint(equalToConstant: C.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: C.avatarSize),
            
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: C.displayNameTop),
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: C.displayNameLeft),
            
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: C.usernameLeft),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: C.usernameRight),
            usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor),
            
            textContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: C.textContentTop),
            textContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            textContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: C.textContentRight),
            
            replyButton.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: C.replyTop),
            replyButton.leadingAnchor.constraint(equalTo: textContentLabel.leadingAnchor),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: C.replyBottom),
            
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: C.buttonSpacing),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: C.buttonSpacing),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
            
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: C.buttonSpacing),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
