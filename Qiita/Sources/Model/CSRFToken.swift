//
//  CSRFToken.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/11.
//

import Foundation

// MARK: - CSRFToken
struct CSRFToken: Codable {
    let settings: Settings
}

// MARK: - Settings
struct Settings: Codable {
    let csrfToken: String
}
