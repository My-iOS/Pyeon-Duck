//
//  TabBarController.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

final class TabBarController: UITabBarController {
    let dataManager = DataManager()

    override func viewDidLoad() {
        setupTabbarController()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.tintColor = .systemOrange

        let paddingTop: CGFloat = 10.0
        tabBar.frame = .init(
            x: tabBar.frame.origin.x,
            y: tabBar.frame.origin.y - paddingTop,
            width: tabBar.frame.width,
            height: tabBar.frame.height + paddingTop
        )
    }
}

extension TabBarController {
    func setupTabbarController() {
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        tabBar.unselectedItemTintColor = .systemPink
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white

        let expirationDateVC = ExpirationCalendarVC()
        expirationDateVC.tabBarItem = configure(title: "유통기한", symbolName: "calendar", tag: 0)

        let stockVC = StockVC()
        stockVC.injectViewModel(StockViewModel(dataManager: dataManager))
        stockVC.tabBarItem = configure(title: "재고", symbolName: "shippingbox", tag: 1)

        let salaryVC = SalaryVC()
        salaryVC.injectViewModel(SalaryViewModel())
        salaryVC.tabBarItem = configure(title: "시급 계산기", symbolName: "wonsign.circle", tag: 2)

        expirationDateVC.tabBarItem.selectedImage = UIImage(named: "calendar.fill")
        stockVC.tabBarItem.selectedImage = UIImage(named: "shippingbox.fill")
        salaryVC.tabBarItem.selectedImage = UIImage(named: "wonsign.circle.fill")

        viewControllers = [expirationDateVC, stockVC, salaryVC]
    }

    func configure(title: String, symbolName: String, tag: Int) -> UITabBarItem {
        return UITabBarItem(title: title, image: UIImage(systemName: symbolName), tag: tag)
    }
}
