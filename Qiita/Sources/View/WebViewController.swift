//
//  WebViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import WebKit
import KeychainAccess

class WebViewController: UIViewController {

    var webView: WKWebView!

    let keychain = Keychain(service: "com.Qiita")

    var observers = [NSKeyValueObservation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)

        let request = URLRequest(url: URL(string: "https://qiita.com/login?redirectTo=%2F")!)
        webView.load(request)

        observeUrl()
    }

    func observeUrl() {
        observers.append(webView.observe(\.url, options: .new) { _, _ in
            guard let url = self.webView.url else { return }
            if url == URL(string: "https://qiita.com/") {
                self.getCookies()
            }
        })
    }
    // _qiita_login_session
    // _ga
    // _gid
    // __gads
    // __gpi
    // mp_17d24b448ca579c365d2d1057f3a1791_mixpanel
    // user_session_key
    // secure_token
    // _td
    // general_banner_displayed
    func getCookies() {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies() { (cookies) in
            for eachcookie in cookies {
                if eachcookie.domain.contains("qiita.com") {
                    print("\(eachcookie.name): \(eachcookie.value)")
                    self.keychain["\(eachcookie.name)"] = "\(eachcookie.value)"
                }
            }
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "user")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
