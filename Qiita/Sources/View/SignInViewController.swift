//
//  SignInViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import Lottie
import SafariServices

class SignInViewController: UIViewController {
    // 背景アニメーション
    @IBOutlet var animationView: AnimationView!
    // 背景アニメーションのぼかし
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        return blurEffectView
    }()
    // Qiitaのロゴ
    var qiitaIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "logo"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit

        return icon
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("ログイン", for: .normal)
        button.setTitleColor(UIColor(red: 61/255, green: 64/255, blue: 64/255, alpha: 255/255), for: .normal)

        button.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .bold)

        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(red: 61/255, green: 64/255, blue: 64/255, alpha: 255/255).cgColor
        button.layer.cornerRadius = 7

        button.addTarget(self, action: #selector(openLogin(_:)), for: .touchDown)

        return button
    }()

    lazy var termsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("利用規約", for: .normal)
        button.setTitleColor(UIColor(red: 61/255, green: 64/255, blue: 64/255, alpha: 255/255), for: .normal)

        button.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .bold)

        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(red: 61/255, green: 64/255, blue: 64/255, alpha: 255/255).cgColor
        button.layer.cornerRadius = 7

        button.addTarget(self, action: #selector(openTerms(_:)), for: .touchDown)

        return button
    }()

    lazy var privacyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("プライバシーポリシー", for: .normal)
        button.setTitleColor(UIColor(red: 61/255, green: 64/255, blue: 64/255, alpha: 255/255), for: .normal)

        button.titleLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .bold)

        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(red: 61/255, green: 64/255, blue: 64/255, alpha: 255/255).cgColor
        button.layer.cornerRadius = 7

        button.addTarget(self, action: #selector(openPrivacy(_:)), for: .touchDown)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.play()

        blurEffectView.frame = animationView.frame
        animationView.addSubview(blurEffectView)

        view.addSubview(qiitaIcon)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)

        NSLayoutConstraint.activate([
            // qiitaIcon
            qiitaIcon.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -30),
            qiitaIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            qiitaIcon.heightAnchor.constraint(equalToConstant: 100),
            // loginButton
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            // termsButton
            termsButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            termsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            termsButton.widthAnchor.constraint(equalToConstant: 250),
            termsButton.heightAnchor.constraint(equalToConstant: 50),
            // privacyButton
            privacyButton.topAnchor.constraint(equalTo: termsButton.bottomAnchor, constant: 20),
            privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            privacyButton.widthAnchor.constraint(equalToConstant: 250),
            privacyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func openLogin(_ sender: UIButton) {
        let webViewController = WebViewController()
        webViewController.modalPresentationStyle = .pageSheet
        present(webViewController, animated: true, completion: nil)
    }

    @objc func openTerms(_ sender: UIButton) {
        guard let url = URL(string: "https://qiita.com/terms") else { return }
        let safariView = SFSafariViewController(url: url)
        safariView.modalPresentationStyle = .fullScreen
        present(safariView, animated: true)
    }

    @objc func openPrivacy(_ sender: UIButton) {
        guard let url = URL(string: "https://qiita.com/privacy") else { return }
        let safariView = SFSafariViewController(url: url)
        safariView.modalPresentationStyle = .fullScreen
        present(safariView, animated: true)
    }
}
