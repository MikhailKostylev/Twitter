//
//  TabBarController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 12.11.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    enum Constants {
        static let dividerHeight: CGFloat = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Setups
    
    private func configureTabBar() {
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .label
        tabBar.backgroundColor = .systemBackground
        
        viewControllers = [
            generateNavigationController(
                title: nil,
                image: R.Image.TabBar.homeIcon,
                selectedImage: R.Image.TabBar.homeIconFill,
                view: HomeViewController()
            ),
            generateNavigationController(
                title: nil,
                image: R.Image.TabBar.searchIcon,
                selectedImage: R.Image.TabBar.searchIconFill,
                view: SearchViewController()
            ),
            generateNavigationController(
                title: nil,
                image: R.Image.TabBar.communitiesIcon,
                selectedImage: R.Image.TabBar.communitiesIconFill,
                view: CommunitiesViewController()
            ),
            generateNavigationController(
                title: nil,
                image: R.Image.TabBar.notificationsIcon,
                selectedImage: R.Image.TabBar.notificationsIconFill,
                view: NotificationsViewController()
            ),
            generateNavigationController(
                title: nil,
                image: R.Image.TabBar.directMessagesIcon,
                selectedImage: R.Image.TabBar.directMessagesIconFill,
                view: DirectMessagesViewController()
            )
        ]
        
        let dividerView = UIView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(
                    width: tabBar.width, height: Constants.dividerHeight)
            )
        )
        dividerView.backgroundColor = .secondarySystemBackground
        tabBar.addSubview(dividerView)
    }
    
    private func generateNavigationController(
        title: String?,
        image: UIImage?,
        selectedImage: UIImage?,
        view: UIViewController
    ) -> UIViewController {
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        view.tabBarItem.selectedImage = selectedImage
        return UINavigationController(rootViewController: view)
    }
}

// MARK: - Delegate

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedTabView = findSelectedView(tabBar, didSelect: item)
        guard let tab = selectedTabView else { return }
        animationOfTabBarButton(tab)
    }
}

// MARK: - Interaction

extension TabBarController {
    private func findSelectedView(_ tabBar: UITabBar, didSelect item: UITabBarItem) -> UIView? {
        var selectedTabView: UIView?

        for i in tabBar.subviews {
            if i == item.value(forKey: "view") as? UIView {
                selectedTabView = i
                break
            }
        }
        return selectedTabView
    }
}

// MARK: - Animation

extension TabBarController {
    private func animationOfTabBarButton(_ view: UIView) {
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.9) {
            view.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
        }
        propertyAnimator.addAnimations({ view.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}
