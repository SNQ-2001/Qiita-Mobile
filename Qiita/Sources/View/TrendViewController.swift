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

    let trendViewModel = TrendViewModel()

    @IBOutlet var trendTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "トレンド"

        trendTableView.register(UINib(nibName: "QiitaTableViewCell", bundle: nil), forCellReuseIdentifier: "QiitaTableViewCell")

        trendTableView.separatorInset = .zero

        initTrendViewModel()

        trendViewModel.requestHomeTrendPage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendViewModel.homeTrendPage.trend.edges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaTableViewCell") as? QiitaTableViewCell {
            let node = trendViewModel.homeTrendPage.trend.edges[indexPath.row].node
            cell.setCell(
                profileImageURL: node.author.profileImageURL,
                id: node.author.urlName,
                name: node.author.name,
                publishedAt: node.publishedAt,
                title: node.title,
                tags: node.tags,
                LGTM: node.likesCount
            )
            return cell
        }
        return UITableViewCell()
    }

    func initTrendViewModel() {
        self.trendViewModel.reloadHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.trendTableView.reloadData()
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
