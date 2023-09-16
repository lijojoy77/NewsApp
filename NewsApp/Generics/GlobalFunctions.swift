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

    let apiKey = "&apiKey=9b7d064d4761450a8f75cd623b457381"
    let baseUrl = "https://newsapi.org/v2/top-headlines?"


    func timeAgoSinceDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)

            if let years = components.year, years > 0 {
                return "\(years) year\(years > 1 ? "s" : "") ago"
            } else if let months = components.month, months > 0 {
                return "\(months) month\(months > 1 ? "s" : "") ago"
            } else if let days = components.day, days > 0 {
                return "\(days) day\(days > 1 ? "s" : "") ago"
            } else if let hours = components.hour, hours > 0 {
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
