//
//  ViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let homeViewModel = HomeViewModel()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ホーム"

        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")

        tableView.separatorInset = .zero

        initHomeViewModel()

        homeViewModel.requestHomeIndexPage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.homeIndexPage.personalizedFeed.personalizedFeed.edges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell {
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
                self?.tableView.reloadData()
            }
        }
    }
    
}


