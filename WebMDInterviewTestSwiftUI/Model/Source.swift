//
//  Source.swift
//  WebMDInterviewTestSwiftUI
//
//  Created by Shweta Ambarkhane on 18/07/24.
//

import Foundation

struct Source: Hashable, Codable {
    var id: String? = UUID().uuidString
    let name: String
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        return lhs.id == rhs.id
    }
}
