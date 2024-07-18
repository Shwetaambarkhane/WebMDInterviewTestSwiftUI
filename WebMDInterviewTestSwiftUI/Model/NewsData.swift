//
//  NewsData.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Shweta Ambarkhane on 18/07/24.
//

import Foundation

struct NewsData: Codable {
    let status: String
    let articles: [NewsArticle]
}
