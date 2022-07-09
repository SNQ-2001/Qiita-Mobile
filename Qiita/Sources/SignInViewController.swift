//
//  SignInViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import Lottie

class SignInViewController: UIViewController {
    // 背景アニメーション
    @IBOutlet var animationView: AnimationView!

    // 背景アニメーションのぼかし
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        return blurEffectView
    }()
//    // Qiitaのロゴ
//    var qiitaIcon: UIImageView = {
//        let icon = UIImageView(image: UIImage(named: "logo"))
//        icon.translatesAutoresizingMaskIntoConstraints = false
//        icon.contentMode = .scaleAspectFit
//        return icon
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.play()

        blurEffectView.frame = view.frame
        animationView.addSubview(blurEffectView)
//
//        qiitaIcon.frame = CGRect(x: 0, y: 0, width: view.frame.size.width/4, height: 30)
//        view.addSubview(qiitaIcon)
//
//        NSLayoutConstraint.activate([
//            qiitaIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
//            qiitaIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
//        ])
    }
}
