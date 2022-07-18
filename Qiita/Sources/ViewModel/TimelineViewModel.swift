//
//  TimelineViewModel.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/18.
//

import Foundation
import Alamofire
import SwiftSoup
import KeychainAccess

class TimelineViewModel: NSObject {

    /// キーチェーン
    public let keychain = Keychain(service: "com.Qiita")

    /// リロードハンドラー
    /// アクションをViewControllerから受け取る
    public var reloadHandler: () -> Void = { }

    /// リポジトリ情報の格納庫
    /// 変更が検知されるとリロードハンドラーが実行される
    public var homeTimelinePage: HomeTimelinePage = HomeTimelinePage(timeline: Timeline(edges: [])) {
        didSet {
            reloadHandler()
        }
    }

    public func requestHomeTimelinePage() {
        guard let user_session_key = self.keychain["user_session_key"] else { return }
        guard let secure_token = self.keychain["secure_token"] else { return }
        guard let _qiita_login_session = self.keychain["_qiita_login_session"] else { return }
        let headers: HTTPHeaders? = [
            "cookie": "user_session_key=\(user_session_key); secure_token=\(secure_token); _qiita_login_session=\(_qiita_login_session)",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"
        ]
        AF.request("https://qiita.com/timeline", method: .get, headers: headers).responseData { response in
            guard let data = response.data else { return }
            do {
                let html: String = String(data: data, encoding: .utf8) ?? ""
                let doc: Document = try SwiftSoup.parse(html)
                let component: Elements = try doc.getElementsByClass("js-react-on-rails-component")
                let elements: [Element] = component.array()
                for element in elements {
                    if try element.attr("data-component-name") == "HomeTimelinePage" {
                        let json = try JSONDecoder().decode(HomeTimelinePage.self, from: element.data().data(using: .utf8)!)
                        self.homeTimelinePage = json
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

