//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 13.11.2022.
//

import UIKit

final class TweetTableViewCell: UITableViewCell {
    static let id = String(describing: TweetTableViewCell.self)
    
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
        view.font = R.Font.displayName
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let view = UILabel()
        view.text = "@username"
        view.numberOfLines = 1
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.font = R.Font.username
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
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
}

// MARK: - Private

private extension TweetTableViewCell {
    func setupContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
    }
    
    func setupSubviews() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(textContentLabel)
        setupLayout()
    }
}

// MARK: - Layout

extension TweetTableViewCell {
    typealias C = Constants
    
    enum Constants {
        static let avatarTopPadding: CGFloat = 15
        static let avatarLeftPadding: CGFloat = 20
        static let avatarSize: CGFloat = 50
        static var avatarCornerRadius: CGFloat {
            avatarSize / 2
        }
        
        static let displayNameTop: CGFloat = 15
        static let displayNameLeft: CGFloat = 20
        
        static let usernameLeft: CGFloat = 10
        static let usernameRight: CGFloat = -10
        
        static let textContentTop: CGFloat = 10
        static let textContentBottom: CGFloat = -15
    }
    
    private func setupLayout() {
        avatarImageView.prepareForAutoLayout()
        displayNameLabel.prepareForAutoLayout()
        usernameLabel.prepareForAutoLayout()
        textContentLabel.prepareForAutoLayout()
        
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
            textContentLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            textContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: C.textContentBottom)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
