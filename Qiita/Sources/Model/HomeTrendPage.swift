//
//  HomeTrendPage.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/18.
//

import Foundation

// MARK: - HomeTrendPage
struct HomeTrendPage: Codable {
    let trend: Trend
}

// MARK: - Trend
struct Trend: Codable {
    let edges: [HomeTrendPageEdge]
}

// MARK: - Edge
struct HomeTrendPageEdge: Codable {
    let node: HomeTrendPageNode
}

// MARK: - Node
struct HomeTrendPageNode: Codable {
    let likesCount: Int
    let linkURL: String
    let publishedAt: Date
    let title: String
    let author: Author
    let organization: Organization?
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case likesCount
        case linkURL = "linkUrl"
        case publishedAt, title, author, organization, tags
    }
}
