//
//  ProfileTableViewHeader.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 14.11.2022.
//

import UIKit

final class ProfileTableViewHeader: UIView {
    
    private var selectedTabIndex = 0 {
        didSet {
            print(selectedTabIndex)
        }
    }
    
    private var headerImageHeight: CGFloat?
    
    // MARK: - UI elements
    
    private let headerImageView: UIImageView = {
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
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.username
        return view
    }()
    
    private let userBioLabel: UILabel = {
        let view = UILabel()
        view.text = "iOS Developer"
        view.numberOfLines = 1
        view.textColor = .label
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.userBio
        return view
    }()
    
    private let locationIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.Image.Profile.location
        view.tintColor = .secondaryLabel
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let locationLabel: UILabel = {
        let view = UILabel()
        view.text = "Moscow"
        view.numberOfLines = 1
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.location
        return view
    }()
    
    private let joinDateIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.Image.Profile.calendar
        view.tintColor = .secondaryLabel
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let joinDateLabel: UILabel = {
        let view = UILabel()
        view.text = "Joined date: June 2022"
        view.numberOfLines = 1
        view.textColor = .secondaryLabel
        view.textAlignment = .left
        view.font = R.Font.ProfileHeader.joinDate
        return view
    }()
    
    private let followingCountLabel: UILabel = {
        let view = UILabel()
        view.text = "1337"
        view.textColor = .label
        view.font = R.Font.ProfileHeader.followingCount
        return view
    }()
    
    private let followingTextLabel: UILabel = {
        let view = UILabel()
        view.text = R.Text.Profile.following
        view.textColor = .secondaryLabel
        view.font = R.Font.ProfileHeader.followingText
        return view
    }()
    
    private let followersCountLabel: UILabel = {
        let view = UILabel()
        view.text = "322"
        view.textColor = .label
        view.font = R.Font.ProfileHeader.followersCount
        return view
    }()
    
    private let followersTextLabel: UILabel = {
        let view = UILabel()
        view.text = R.Text.Profile.followers
        view.textColor = .secondaryLabel
        view.font = R.Font.ProfileHeader.followersText
        return view
    }()
    
    private let tabs: [UIButton] = [
        R.Text.Profile.tab1,
        R.Text.Profile.tab2,
        R.Text.Profile.tab3,
        R.Text.Profile.tab4
    ].enumerated().map { (index, buttonTitle) in
        let button = UIButton(type: .system)
        button.tintColor = .label
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = R.Font.ProfileHeader.tabs
        button.tag = index
        return button
    }
    
    private lazy var tabsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: tabs)
        view.distribution = .equalSpacing
        view.axis = .horizontal
        view.alignment = .center
        return view
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.twitter
        return view
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, headerImageHeight: CGFloat) {
        self.headerImageHeight = headerImageHeight
        super.init(frame: frame)
        setupView()
        addSubviews()
        addTabButtonActions()
        setupLayout()
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
    
    func addSubviews() {
        [
            headerImageView,
            avatarBackgroundCircle,
            avatarImageView,
            displayNameLabel,
            usernameLabel,
            userBioLabel,
            locationIcon,
            locationLabel,
            joinDateIcon,
            joinDateLabel,
            followingCountLabel,
            followingTextLabel,
            followersCountLabel,
            followersTextLabel,
            tabsStackView,
            divider
        ].forEach { addSubview($0) }
    }
    
    func addTabButtonActions() {
        tabs.forEach { $0.addTarget(self, action: #selector(didTapTabButton(_:)), for: .touchUpInside) }
    }
}

// MARK: - Actions

private extension ProfileTableViewHeader {
    @objc func didTapTabButton(_ sender: UIButton) {
        selectedTabIndex = sender.tag
    }
}

// MARK: - Layout

private extension ProfileTableViewHeader {
    typealias C = Constants
    
    enum Constants {
        static let headerImageHeight: CGFloat = 150

        static let iconsSize: CGFloat = 18
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
        static let userBioRight: CGFloat = -20
        
        static let locationIconTop: CGFloat = 10
        static let locationLabelLeft: CGFloat = 2
        
        static let joinDateIconTop: CGFloat = 10
        static let joinDateLabelLeft: CGFloat = 2
        
        static let followingCountTop: CGFloat = 10
        static let followingTextLeft: CGFloat = 4
        
        static let followersCountLeft: CGFloat = 10
        static let followersTextLeft: CGFloat = 4
        
        static let tabsStackTop: CGFloat = 10
        static let tabsStackLeft: CGFloat = 20
        static let tabsStackRight: CGFloat = -20
        static let tabsStackHeight: CGFloat = 35
        
        static let dividerHeight: CGFloat = 1
    }
    
    func setupLayout() {
        [
            headerImageView,
            avatarBackgroundCircle,
            avatarImageView,
            displayNameLabel,
            usernameLabel,
            userBioLabel,
            locationIcon,
            locationLabel,
            joinDateIcon,
            joinDateLabel,
            followingCountLabel,
            followingTextLabel,
            followersCountLabel,
            followersTextLabel,
            tabsStackView,
            divider
        ].forEach { $0.prepareForAutoLayout() }
        
        let headerImageHeight = headerImageHeight ?? C.headerImageHeight
        
        let constraints = [
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: headerImageHeight),
            
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: C.avatarLeftPadding),
            avatarImageView.centerYAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: C.avatarYPadding),
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
            joinDateLabel.bottomAnchor.constraint(equalTo: joinDateIcon.bottomAnchor),
            
            followingCountLabel.topAnchor.constraint(equalTo: joinDateIcon.bottomAnchor, constant: C.followingCountTop),
            followingCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: C.followingTextLeft),
            followingTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor),
                        
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor, constant: C.followersCountLeft),
            followersCountLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor),
            
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor, constant: C.followersTextLeft),
            followersTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor),
            
            tabsStackView.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor, constant: C.tabsStackTop),
            tabsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: C.tabsStackLeft),
            tabsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: C.tabsStackRight),
            tabsStackView.heightAnchor.constraint(equalToConstant: C.tabsStackHeight),
            
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: C.dividerHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
