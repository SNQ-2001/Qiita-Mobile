//
//  ViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import Alamofire
import SwiftSoup
import KeychainAccess
import SwiftUI

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let keychain = Keychain(service: "com.Qiita")

    var csrfToken: String = ""

    var homeIndexPage: HomeIndexPage = HomeIndexPage(personalizedFeed: HomeIndexPagePersonalizedFeed(personalizedFeed: PersonalizedFeedPersonalizedFeed(edges: []))) {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ホーム"

        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.separatorInset = .zero

        getCsrfToken()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeIndexPage.personalizedFeed.personalizedFeed.edges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell {
            let node = homeIndexPage.personalizedFeed.personalizedFeed.edges[indexPath.row].node
            cell.setCell(profileImageURL: node.author.profileImageURL, title: node.title, id: node.author.urlName, name: node.author.name, tags: node.tags, LGTM: node.likesCount)
            return cell
        }
        return UITableViewCell()
    }

    func getCsrfToken() {
        guard let user_session_key = keychain["user_session_key"] else { return }
        guard let secure_token = keychain["secure_token"] else { return }
        guard let _qiita_login_session = keychain["_qiita_login_session"] else { return }
        let headers: HTTPHeaders? = [
            "cookie": "user_session_key=\(user_session_key); secure_token=\(secure_token); _qiita_login_session=\(_qiita_login_session)",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"
        ]
        AF.request("https://qiita.com/", method: .get, headers: headers).responseData { response in
            guard let data = response.data else { return }
            do {
                let html: String = String(data: data, encoding: .utf8) ?? ""
                let doc: Document = try SwiftSoup.parse(html)
//                let link: Element = try doc.getElementById("js-react-on-rails-context")!
//                let csrf_token = try JSONDecoder().decode(CSRFToken.self, from: link.data().data(using: .utf8)!)
//
//                self.csrfToken = csrf_token.settings.csrfToken

                let component: Elements = try doc.getElementsByClass("js-react-on-rails-component")
                let elements: [Element] = component.array()
                for element in elements {
                    if try element.attr("data-component-name") == "HomeIndexPage" {
                        let json = try JSONDecoder().decode(HomeIndexPage.self, from: element.data().data(using: .utf8)!)
                        self.homeIndexPage = json
                    }
                }

            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error")
            }
        }
    }

    // 更新
    func getJSON() {
        guard let user_session_key = keychain["user_session_key"] else { return }
        guard let secure_token = keychain["secure_token"] else { return }
        guard let _qiita_login_session = keychain["_qiita_login_session"] else { return }

        let headers: HTTPHeaders? = [
            "cookie": "user_session_key=\(user_session_key); secure_token=\(secure_token); _qiita_login_session=\(_qiita_login_session)",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36",
            "x-csrf-token": "\(csrfToken)"
        ]

        let parameters: [String: Any] = ["operationName": "GetPersonalizedFeed", "variables": ["after": "MzA=", "first": 30], "query": "query GetPersonalizedFeed($first: Int!, $after: String) {\n  personalizedFeed(first: $first, after: $after) {\n    ...PersonalizedFeedResult\n    __typename\n  }\n}\n\nfragment PersonalizedFeedResult on FeedConnection {\n  edges {\n    isLikedByViewer\n    followingLikers {\n      profileImageUrl\n      urlName\n      __typename\n    }\n    node {\n      ...UnifiedArticleResult\n      __typename\n    }\n    __typename\n  }\n  pageInfo {\n    endCursor\n    hasNextPage\n    __typename\n  }\n  __typename\n}\n\nfragment UnifiedArticleResult on Article {\n  encryptedId\n  isLikedByViewer\n  isStockableByViewer\n  isStockedByViewer\n  likesCount\n  linkUrl\n  publishedAt\n  title\n  uuid\n  author {\n    profileImageUrl\n    urlName\n    name\n    __typename\n  }\n  organization {\n    name\n    urlName\n    __typename\n  }\n  followingLikers {\n    urlName\n    __typename\n  }\n  recentlyFollowingLikers {\n    profileImageUrl\n    urlName\n    __typename\n  }\n  tags {\n    urlName\n    name\n    __typename\n  }\n  __typename\n}\n"]
        AF.request("https://qiita.com/graphql", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            guard let data = response.data else { return }

            print(String.init(data: data, encoding: .utf8)!)
        }
    }
}


