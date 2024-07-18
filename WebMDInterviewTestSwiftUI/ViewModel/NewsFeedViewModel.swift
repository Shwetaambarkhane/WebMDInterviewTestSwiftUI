//
//  NewsFeedViewModel.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Ramadugu, Akshith on 1/17/24.
//

import Foundation
import Dispatch

class NewsFeedViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var errorMessage: String? = nil

    // Function to load news feed
    func loadNewsFeed() {
        // fetchNews and handle its response
        // Please show only the first 25 articles
        
        let newsApi = NewsAPI()
        newsApi.fetchNews() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = Array(articles.prefix(25))
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

