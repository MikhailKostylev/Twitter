//
//  ProfileTableViewHeader.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 14.11.2022.
//

import UIKit

final class ProfileTableViewHeader: UIView {
    
    // MARK: - UI elements
    
    private let profileHeaderImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "testHeaderImage")
        view.backgroundColor = .secondarySystemBackground
        view.clipsToBounds = true
        return view
    }()
    
    private let avatarBackgroundCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = C.avatarBackgroundCircleCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(systemName: "person.circle")
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = C.avatarCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let displayNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Display Name"
        view.numberOfLines = 1
        view.textColor = .label
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.displayName
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let view = UILabel()
        view.text = "@username"
        view.numberOfLines = 1
        view.textColor = .gray
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.username
        return view
    }()
    
    private let userBioLabel: UILabel = {
        let view = UILabel()
        view.text = "iOS Developer"
        view.numberOfLines = 3
        view.textColor = .label
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.userBio
        return view
    }()
    
    private let locationIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.Image.Profile.location
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let locationLabel: UILabel = {
        let view = UILabel()
        view.text = "Moscow"
        view.numberOfLines = 1
        view.textColor = .gray
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.location
        return view
    }()
    
    private let joinDateIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.Image.Profile.calendar
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let joinDateLabel: UILabel = {
        let view = UILabel()
        view.text = "Joined date: June 2022"
        view.numberOfLines = 1
        view.textColor = .gray
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.joinDate
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setups

private extension ProfileTableViewHeader {
    func setupView() {
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    func setupSubviews() {
        addSubview(profileHeaderImageView)
        addSubview(avatarBackgroundCircle)
        addSubview(avatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userBioLabel)
        addSubview(locationIcon)
        addSubview(locationLabel)
        addSubview(joinDateIcon)
        addSubview(joinDateLabel)
        setupLayout()
    }
}

// MARK: - Layout

private extension ProfileTableViewHeader {
    typealias C = Constants
    
    enum Constants {
        static let iconsSize: CGFloat = 20
        static let profileHeaderHeight: CGFloat = 180
        
        static var avatarBackgroundCircleSize: CGFloat {
            avatarSize + 4
        }
        static var avatarBackgroundCircleCornerRadius: CGFloat {
            avatarBackgroundCircleSize / 2
        }
        
        static let avatarLeftPadding: CGFloat = 20
        static let avatarYPadding: CGFloat = 10
        static let avatarBorderWidth: CGFloat = 4
        static let avatarSize: CGFloat = 80
        static var avatarCornerRadius: CGFloat {
            avatarSize / 2
        }
        
        static let displayNameTop: CGFloat = 5
        static let usernameTop: CGFloat = 5
        
        static let userBioTop: CGFloat = 15
        static let userBioRight: CGFloat = -10
        
        static let locationIconTop: CGFloat = 10
        static let locationLabelLeft: CGFloat = 2
        
        static let joinDateIconTop: CGFloat = 10
        static let joinDateLabelLeft: CGFloat = 2
    }
    
    func setupLayout() {
        profileHeaderImageView.prepareForAutoLayout()
        avatarBackgroundCircle.prepareForAutoLayout()
        avatarImageView.prepareForAutoLayout()
        displayNameLabel.prepareForAutoLayout()
        usernameLabel.prepareForAutoLayout()
        userBioLabel.prepareForAutoLayout()
        locationIcon.prepareForAutoLayout()
        locationLabel.prepareForAutoLayout()
        joinDateIcon.prepareForAutoLayout()
        joinDateLabel.prepareForAutoLayout()
        
        let constraints = [
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: C.profileHeaderHeight),
            
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: C.avatarLeftPadding),
            avatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: C.avatarYPadding),
            avatarImageView.widthAnchor.constraint(equalToConstant: C.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: C.avatarSize),
            
            avatarBackgroundCircle.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            avatarBackgroundCircle.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            avatarBackgroundCircle.widthAnchor.constraint(equalToConstant: C.avatarBackgroundCircleSize),
            avatarBackgroundCircle.heightAnchor.constraint(equalToConstant: C.avatarBackgroundCircleSize),
            
            displayNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: C.displayNameTop),
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: C.usernameTop),
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: C.userBioTop),
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: C.userBioRight),
            
            locationIcon.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: C.locationIconTop),
            locationIcon.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            locationIcon.widthAnchor.constraint(equalToConstant: C.iconsSize),
            locationIcon.heightAnchor.constraint(equalToConstant: C.iconsSize),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: C.locationLabelLeft),
            locationLabel.bottomAnchor.constraint(equalTo: locationIcon.bottomAnchor),
            
            joinDateIcon.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: C.joinDateIconTop),
            joinDateIcon.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateIcon.widthAnchor.constraint(equalToConstant: C.iconsSize),
            joinDateIcon.heightAnchor.constraint(equalToConstant: C.iconsSize),
            
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateIcon.trailingAnchor, constant: C.joinDateLabelLeft),
            joinDateLabel.bottomAnchor.constraint(equalTo: joinDateIcon.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
