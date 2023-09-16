//
//  GlobalFunctions.swift
//  NewsApp
//
//  Created by Lijo Joy on 13/09/2023.
//

import Foundation

class GlobalFunctions {
    // Create a shared instance (singleton)
    static let shared = GlobalFunctions()

    // Private initializer to prevent external instantiation
    private init() {}

    let apiKey = "&apiKey=868e8e63724746a3820e0dce4eff8622"//925aafe06f494e4fb67bff42f398000e
    let baseUrl = "https://newsapi.org/v2/top-headlines?"


    func timeAgoSinceDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.hour, .minute, .second], from: date, to: now)

            if let hours = components.hour, hours > 0 {
                return "\(hours) hour\(hours > 1 ? "s" : "") ago"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
            } else if let seconds = components.second {
                return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
            }
        }

        return "N/A" 
    }
  
    
    
}
