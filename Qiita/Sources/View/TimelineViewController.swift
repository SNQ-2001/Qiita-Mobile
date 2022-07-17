//
//  TimelineViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import KeychainAccess

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let keychain = Keychain(service: "com.Qiita")

    @IBOutlet var timelineTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "タイムライン"

//        keychain["_qiita_login_session"] = nil
//        keychain["_ga"] = nil
//        keychain["_gid"] = nil
//        keychain["__gads"] = nil
//        keychain["__gpi"] = nil
//        keychain["mp_17d24b448ca579c365d2d1057f3a1791_mixpanel"] = nil
//        keychain["user_session_key"] = nil
//        keychain["secure_token"] = nil
//        keychain["_td"] = nil
//        keychain["general_banner_displayed"] = nil

        timelineTableView.separatorInset = .zero

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "あいうえお"
        return cell
    }

}
