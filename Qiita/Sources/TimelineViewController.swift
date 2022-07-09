//
//  TimelineViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import KeychainAccess

class TimelineViewController: UIViewController {
    let keychain = Keychain(service: "com.Qiita")
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "タイムライン"

        keychain["auth"] = nil
    }

}
