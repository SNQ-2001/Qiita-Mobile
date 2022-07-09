//
//  SignInViewController.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/09.
//

import UIKit
import KeychainAccess

class SignInViewController: UIViewController {
    let keychain = Keychain(service: "com.Qiita")
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
    
    @IBAction func tap(_ sender: Any) {
        keychain["auth"] = "01234567-89ab-cdef-0123-456789abcdef"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
