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

class HomeViewController: UIViewController {
    let keychain = Keychain(service: "com.Qiita")
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ホーム"

        getCsrfToken()
//        getJSON()
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
                let link: Element = try doc.getElementById("js-react-on-rails-context")!
                let csrf_token = try JSONDecoder().decode(CSRFToken.self, from: link.data().data(using: .utf8)!)
                print(csrf_token.settings.csrfToken)
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error")
            }
        }
    }

    func getJSON() {

        guard let user_session_key = keychain["user_session_key"] else { return }
        guard let secure_token = keychain["secure_token"] else { return }
        guard let _qiita_login_session = keychain["_qiita_login_session"] else { return }

        guard let _td = keychain["_td"] else { return }

        let headers: HTTPHeaders? = [
            "cookie": "user_session_key=\(user_session_key); secure_token=\(secure_token); _qiita_login_session=\(_qiita_login_session)",

            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36",
//            "x-csrf-token": "CYsscvo5XoI4WtwazMwXYAL4zugMBSDwf2Ks9I1Ubi/eao0vMlP1MzT2EZ0yr24wV+5cIoaGWVDi+n9zgRsW6A=="
            "x-csrf-token": "\(_td)"
        ]
        let parameters: [String: Any] = ["operationName": "GetPersonalizedFeed", "variables": ["after": "MzA=", "first": 30], "query": "query GetPersonalizedFeed($first: Int!, $after: String) {\n  personalizedFeed(first: $first, after: $after) {\n    ...PersonalizedFeedResult\n    __typename\n  }\n}\n\nfragment PersonalizedFeedResult on FeedConnection {\n  edges {\n    isLikedByViewer\n    followingLikers {\n      profileImageUrl\n      urlName\n      __typename\n    }\n    node {\n      ...UnifiedArticleResult\n      __typename\n    }\n    __typename\n  }\n  pageInfo {\n    endCursor\n    hasNextPage\n    __typename\n  }\n  __typename\n}\n\nfragment UnifiedArticleResult on Article {\n  encryptedId\n  isLikedByViewer\n  isStockableByViewer\n  isStockedByViewer\n  likesCount\n  linkUrl\n  publishedAt\n  title\n  uuid\n  author {\n    profileImageUrl\n    urlName\n    name\n    __typename\n  }\n  organization {\n    name\n    urlName\n    __typename\n  }\n  followingLikers {\n    urlName\n    __typename\n  }\n  recentlyFollowingLikers {\n    profileImageUrl\n    urlName\n    __typename\n  }\n  tags {\n    urlName\n    name\n    __typename\n  }\n  __typename\n}\n"]
        AF.request("https://qiita.com/graphql", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            guard let data = response.data else { return }

            print(String.init(data: data, encoding: .utf8)!)
        }
    }
}


