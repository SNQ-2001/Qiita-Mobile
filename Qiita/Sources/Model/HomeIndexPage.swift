//
//  HomeIndexPage.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/12.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeIndexPage = try? newJSONDecoder().decode(HomeIndexPage.self, from: jsonData)

import Foundation

// MARK: - HomeIndexPage
struct HomeIndexPage: Codable {
    let personalizedFeed: HomeIndexPagePersonalizedFeed
}

// MARK: - HomeIndexPagePersonalizedFeed
struct HomeIndexPagePersonalizedFeed: Codable {
    let personalizedFeed: PersonalizedFeedPersonalizedFeed
}

// MARK: - PersonalizedFeedPersonalizedFeed
struct PersonalizedFeedPersonalizedFeed: Codable {
    let edges: [HomeIndexPageEdge]
}

// MARK: - Edge
struct HomeIndexPageEdge: Codable {
    let node: HomeIndexPageNode
}

// MARK: - Node
struct HomeIndexPageNode: Codable {
    let encryptedID: String
    let likesCount: Int
    let linkURL: String
    let publishedAt: String
    let title: String
    let author: Author
    let organization: Organization?
    let tags: [Tag]

    enum CodingKeys: String, CodingKey {
        case encryptedID = "encryptedId"
        case likesCount
        case linkURL = "linkUrl"
        case publishedAt, title, author, organization, tags
    }
}

// MARK: - Author
struct Author: Codable {
    let profileImageURL: String
    let urlName, name: String

    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profileImageUrl"
        case urlName, name
    }
}

// MARK: - Organization
struct Organization: Codable {
    let name, urlName: String
}

// MARK: - Tag
struct Tag: Codable {
    let name, urlName: String
}
