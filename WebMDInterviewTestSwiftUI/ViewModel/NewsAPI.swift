//
//  NewsAPI.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Ramadugu, Akshith on 1/17/24.
//

import Foundation

struct NewsAPI {
    static let apiKey = "90cb3a480ee245afb759b8e17c6de0b8"
    static let baseURL = "https://newsapi.org"
    static let params = "/v2/everything?q=tesla&sortBy=publishedAt&apiKey="
//https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=90cb3a480ee245afb759b8e17c6de0b8
    
    var session: URLSession
        
    init(session: URLSession = .shared) {
        self.session = session
    }

    // Function to fetch news from the API
    func fetchNews(completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        // 1. Construct the URL with the correct parameters.
        // 2. Perform a URLSession data task to fetch the news.
        // 3. Decode the JSON response into an array of NewsArticle.
        // 4. Call the completion handler with the fetched articles or an error.
        
        let urlString = "\(NewsAPI.baseURL)\(NewsAPI.params)\(NewsAPI.apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let newsData = try JSONDecoder().decode(NewsData.self, from: data)
                completion(.success(newsData.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
