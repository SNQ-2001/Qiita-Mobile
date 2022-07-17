//
//  ViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let homeViewModel = HomeViewModel()

    @IBOutlet var homeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ホーム"

        homeTableView.register(UINib(nibName: "QiitaTableViewCell", bundle: nil), forCellReuseIdentifier: "QiitaTableViewCell")

        homeTableView.separatorInset = .zero

        initHomeViewModel()

        homeViewModel.requestHomeIndexPage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.homeIndexPage.personalizedFeed.personalizedFeed.edges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QiitaTableViewCell") as? QiitaTableViewCell {
            let node = homeViewModel.homeIndexPage.personalizedFeed.personalizedFeed.edges[indexPath.row].node
            cell.setCell(
                profileImageURL: node.author.profileImageURL,
                title: node.title,
                id: node.author.urlName,
                name: node.author.name,
                tags: node.tags,
                LGTM: node.likesCount
            )
            return cell
        }
        return UITableViewCell()
    }

    func initHomeViewModel() {
        self.homeViewModel.reloadHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
            }
        }
    }
    
}


