//
//  NewsArticle.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Ramadugu, Akshith on 1/17/24.
//

import Foundation

struct NewsArticle: Hashable, Codable {
    
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String
    let source: Source
}

