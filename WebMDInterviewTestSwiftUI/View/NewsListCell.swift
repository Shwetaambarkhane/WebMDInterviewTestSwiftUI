//
//  NewsListCell.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Shweta Ambarkhane on 17/07/24.
//

import SwiftUI

struct NewsListCell: View {
    let article: NewsArticle

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 100)
            } placeholder: {
                ProgressView()
                    .frame(width: 75, height: 75)
            }
            VStack(alignment: .leading) {
                if let title = article.title {
                    Text(title)
                        .font(.headline)
                }
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                }
            }
        }
    }
}
