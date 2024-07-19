//
//  WebMDInterviewTestSwiftUITests.swift
//  WebMDInterviewTestSwiftUITests
//
//  Created by Ramadugu, Akshith on 1/17/24.
//

import XCTest
import Foundation

@testable import WebMDInterviewTestSwiftUI

final class WebMDInterviewTestSwiftUITests: XCTestCase {
    
    var newsAPI: NewsAPI!
    var jsonString: String = ""
    /**
     1. Write 1 unit test to ensure that the NewsAPI is working as expected.
     - BONUS: Mock the API
     2. Write 1 unit test to ensure that the news articles are properly decoded
     3. OPTIONAL: Write at least 1 unit test for a functionality you think that it needs to be covered by tests.
     */

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        newsAPI = NewsAPI()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        newsAPI.session = URLSession(configuration: config)
        
        // Mock response data
        jsonString = """
        {
          "status": "ok",
          "totalResults": 9523,
          "articles": [
            {
              "source": {
                "id": null,
                "name": "Electrek"
              },
              "title": "Tesla News",
              "description": "Description of the news",
              "url": "https://example.com",
              "urlToImage": "https://example.com/image.jpg",
              "publishedAt": "2024-07-17T18:07:00Z",
            }
            ]
        }
        """
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        newsAPI = nil
        jsonString = ""
    }
    
    func testFetchNews_Success() {
            let mockData = jsonString.data(using: .utf8)!
            
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: nil
                )!
                return (response, mockData)
            }
            
            let expectation = self.expectation(description: "Fetch News")
            
            newsAPI.fetchNews { result in
                switch result {
                case .success(let articles):
                    XCTAssertEqual(articles.count, 1)
                    XCTAssertEqual(articles.first?.title, "Tesla News")
                    XCTAssertEqual(articles.first?.description, "Description of the news")
                case .failure(let error):
                    XCTFail("Unexpected failure: \(error)")
                }
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 5, handler: nil)
        }
    
    func testDecodingNewsResponse() {
        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            // Decode the JSON data
            let decodedResponse = try JSONDecoder().decode(NewsData.self, from: jsonData)
            
            // Verify the results
            XCTAssertEqual(decodedResponse.articles.count, 1, "The number of articles should be 1.")
            
            let article = decodedResponse.articles.first
            XCTAssertNotNil(article, "The first article should not be nil.")
            XCTAssertEqual(article?.title, "Tesla News", "The title of the article should be 'Tesla News'.")
            XCTAssertEqual(article?.description, "Description of the news", "The description of the article should be 'Description of the news'.")
            XCTAssertEqual(article?.urlToImage, "https://example.com/image.jpg", "The URL to the image should be 'https://example.com/image.jpg'.")
            XCTAssertEqual(article?.publishedAt, "2024-07-17T18:07:00Z", "The published date should be '2024-07-17T18:07:00Z'.")
            
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
