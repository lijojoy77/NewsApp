//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Lijo Joy on 13/09/2023.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int?
    var articles: [Article]?
    let error: NewsAPIError?
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}

struct NewsAPIError: Codable {
    let code: String
    let message: String
}

