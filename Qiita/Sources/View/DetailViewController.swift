//
//  DetailViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var linkURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let label = UILabel()
        label.text = linkURL
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])

    }

}
