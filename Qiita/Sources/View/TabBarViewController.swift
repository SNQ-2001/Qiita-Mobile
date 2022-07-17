//
//  TabBarViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit

class TabBarViewController: UITabBarController {

    var qiitaIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "logo-background-color"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TabBarに色をつける
        if #available(iOS 15.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }

        // Tabが選択された時の色を指定
        tabBar.tintColor = UIColor(red: 85/255, green: 197/255, blue: 0/255, alpha: 1.0)

        // NavigationBarに画像を設定
        navigationItem.titleView = qiitaIcon

    }

}
