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

        navigationItem.titleView = qiita
    }

}
