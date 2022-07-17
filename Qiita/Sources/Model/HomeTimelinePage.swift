//
//  HomeTimelinePage.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/17.
//

import Foundation

// MARK: - HomeTimelinePage
struct HomeTimelinePage: Codable {
    let timeline: Timeline
    let per: Int
    let type: String
}

// MARK: - Timeline
struct Timeline: Codable {
    let edges: [HomeTimelinePageEdge]
}

// MARK: - Edge
struct HomeTimelinePageEdge: Codable {
    let node: HomeTimelinePageNode
}

// MARK: - Node
struct HomeTimelinePageNode: Codable {
    let likesCount: Int
    let linkURL: String
    let publishedAt: Date?
    let title: String?
    let author: HomeTimelinePageAuthor?
    let organization: Organization?
    let tags: [Tag]?

    enum CodingKeys: String, CodingKey {
        case likesCount
        case linkURL = "linkUrl"
        case publishedAt, title, author, organization, tags
    }
}


// MARK: - Author
struct HomeTimelinePageAuthor: Codable {
    let profileImageURL: String
    let urlName, name: String

    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profileImageUrl"
        case urlName, name
    }
}
