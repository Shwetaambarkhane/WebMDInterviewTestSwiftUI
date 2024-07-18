//
//  NewsArticleView.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Ramadugu, Akshith on 1/17/24.
//

import SwiftUI

struct NewsArticleView: View {
    let article: NewsArticle

    var body: some View {
        ScrollView {
            // Display the article's image at the top (if available).
            // Show the article's title.
            // Show the full description of the article.
            // Style the view to ensure it is user-friendly and matches the design aesthetic.
            // Optionally, add more elements or information as needed.
            
            VStack {
                if let imageUrl = article.urlToImage {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                }
                if let title = article.title {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                }
                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .padding()
                }
                Text("Source: \(article.source.name)")
                    .font(.body)
                    .padding()
                if let publishedAt = NewsArticleViewModel().formattedDate(from: article.publishedAt) {
                    Text("Published at: \(publishedAt)")
                        .font(.body)
                        .padding()
                }
            }
        }
    }
}
