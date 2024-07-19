//
//  NewsArticleViewModel.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Shweta Ambarkhane on 18/07/24.
//

import Foundation

struct NewsArticleViewModel {
    
    static func formattedDate(from originalDateString: String) -> String? {
        // DateFormatter to parse the original date string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // DateFormatter to format the Date object to the desired output string
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy, hh:mm a"
        
        // Parse the original date string to a Date object and format it to the new string format
        if let date = inputFormatter.date(from: originalDateString) {
            let formattedDateString = outputFormatter.string(from: date)
            print("Formatted Date String: \(formattedDateString)")
            return formattedDateString
        } else {
            print("Invalid date format")
            return nil
        }
    }
        
}
