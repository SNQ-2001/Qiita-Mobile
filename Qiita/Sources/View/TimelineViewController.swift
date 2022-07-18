//
//  TimelineViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import Alamofire
import SwiftSoup
import KeychainAccess

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let timelineViewModel = TimelineViewModel()

    @IBOutlet var timelineTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "タイムライン"

        timelineTableView.register(UINib(nibName: "QiitaTableViewCell", bundle: nil), forCellReuseIdentifier: "QiitaTableViewCell")

        timelineTableView.separatorInset = .zero

        timelineViewModel.requestHomeTimelinePage()

        initTimelineViewModel()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineViewModel.homeTimelinePage.timeline.edges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaTableViewCell") as? QiitaTableViewCell {
            let node = timelineViewModel.homeTimelinePage.timeline.edges[indexPath.row].node
            cell.setCell(
                profileImageURL: node.author?.profileImageURL ?? "",
                id: node.author?.urlName ?? "???",
                name: node.author?.name ?? "???",
                publishedAt: node.publishedAt ?? "???",
                title: node.title ?? "???",
                tags: node.tags ?? [],
                LGTM: node.likesCount
            )
            return cell
        }
        return UITableViewCell()
    }

    func initTimelineViewModel() {
        self.timelineViewModel.reloadHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.timelineTableView.reloadData()
            }
        }
    }

}
