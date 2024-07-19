//
//  NewsListView.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Ramadugu, Akshith on 1/17/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel: NewsFeedViewModel
    @State private var isAlertPresented: Bool = true

    var body: some View {
        NavigationView {
            // 1. Use a List to display news articles.
            // 2. Each article cell should show an image,title, and description.
            // 3. Implement navigation to a detail view on selection.
            List(viewModel.articles, id: \.self) { article in
                NavigationLink(
                    destination: NewsArticleView(article: article)) {
                        NewsListCell(article: article)
                    }
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.loadNewsFeed()
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.value), dismissButton: .default(Text("OK")))
            }
        }
    }
}
