//
//  TrendViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import Alamofire
import SwiftSoup
import KeychainAccess

class TrendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let keychain = Keychain(service: "com.Qiita")

    var homeTrendPage: HomeTrendPage = HomeTrendPage(trend: Trend(edges: [])) {
        didSet {
            trendTableView.reloadData()
        }
    }

    @IBOutlet var trendTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "トレンド"

        trendTableView.register(UINib(nibName: "QiitaTableViewCell", bundle: nil), forCellReuseIdentifier: "QiitaTableViewCell")

        trendTableView.separatorInset = .zero

        requestHomeTrendPage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = "あい上お"

        return cell
    }

    public func requestHomeTrendPage() {
        guard let user_session_key = self.keychain["user_session_key"] else { return }
        guard let secure_token = self.keychain["secure_token"] else { return }
        guard let _qiita_login_session = self.keychain["_qiita_login_session"] else { return }
        let headers: HTTPHeaders? = [
            "cookie": "user_session_key=\(user_session_key); secure_token=\(secure_token); _qiita_login_session=\(_qiita_login_session)",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"
        ]
        AF.request("https://qiita.com/trend", method: .get, headers: headers).responseData { response in
            guard let data = response.data else { return }
            do {
                let html: String = String(data: data, encoding: .utf8) ?? ""
                let doc: Document = try SwiftSoup.parse(html)
                let component: Elements = try doc.getElementsByClass("js-react-on-rails-component")
                let elements: [Element] = component.array()
                for element in elements {
                    if try element.attr("data-component-name") == "HomeTrendPage" {
                        let json = try JSONDecoder().decode(HomeTrendPage.self, from: element.data().data(using: .utf8)!)
                        print(json)
                    }
                }
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error")
            }
        }
    }
}

//keychain["_qiita_login_session"] = nil
//keychain["_ga"] = nil
//keychain["_gid"] = nil
//keychain["__gads"] = nil
//keychain["__gpi"] = nil
//keychain["mp_17d24b448ca579c365d2d1057f3a1791_mixpanel"] = nil
//keychain["user_session_key"] = nil
//keychain["secure_token"] = nil
//keychain["_td"] = nil
//keychain["general_banner_displayed"] = nil
