//
//  DetailViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/18.
//

import UIKit
import WebKit
import Alamofire
import SwiftSoup
import KeychainAccess

class DetailViewController: UIViewController {
    
    var linkURL = ""

    var webView: WKWebView!

    public let keychain = Keychain(service: "com.Qiita")

    var loadString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)

        webView.scrollView.delegate = self

        requestDetailPage()
    }
    
    public func requestDetailPage() {
        guard let user_session_key = self.keychain["user_session_key"] else { return }
        guard let secure_token = self.keychain["secure_token"] else { return }
        guard let _qiita_login_session = self.keychain["_qiita_login_session"] else { return }
        let headers: HTTPHeaders? = [
            "cookie": "user_session_key=\(user_session_key); secure_token=\(secure_token); _qiita_login_session=\(_qiita_login_session)",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"
        ]
        AF.request(linkURL, method: .get, headers: headers).responseData { response in
            guard let data = response.data else { return }
            do {
                guard let html: String = String(data: data, encoding: .utf8) else { return }
                let doc: Document = try SwiftSoup.parse(html)
                guard let element: Element = try doc.getElementById("personal-public-article-body") else { return }
                let articleBody: String = try element.html()

                self.loadString = "<!DOCTYPE html><html lang=\"ja\"><head><meta charset=\"UTF-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><link rel=\"stylesheet\" media=\"all\" href=\"article.css\"><title>Document</title></head><body><section class=\"it-MdContent\">\(articleBody)</section></body></html>"
                let urlpath = Bundle.main.path(forResource: "article", ofType: "css")
                let url = NSURL.fileURL(withPath: urlpath!)
                self.webView.loadHTMLString(self.loadString, baseURL: url)
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error")
            }
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
