//
//  HomeViewModel.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/15.
//

import Foundation

class ViewModel: NSObject {
    var inputText: String?

    func greetings() -> String {
        let name = inputText?.uppercased() ?? ""
        return "Hello, \(name)!"
    }

    func buttonIsEnabled() -> Bool {
        return !(inputText ?? "").isEmpty
    }
}
