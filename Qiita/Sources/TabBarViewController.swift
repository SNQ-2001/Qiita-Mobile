//
//  TabBarViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit

class TabBarViewController: UITabBarController {

    var qiita: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo-background-color"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // NavigationBarに画像を設定
        navigationItem.titleView = qiita

        // Tabが選択された時の色を指定
        tabBar.tintColor = UIColor(red: 85/255, green: 197/255, blue: 0/255, alpha: 1.0)

    }

}
