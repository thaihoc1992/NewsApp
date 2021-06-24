//
//  News.swift
//  newsApp
//
//  Created by ADMIN on 6/24/21.
//

import Foundation
import SwiftyJSON

class News {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    required public init?(json: JSON) {
        self.status = json["status"].stringValue
        self.totalResults = json["totalResults"].intValue
        self.articles = json["articles"].arrayValue.map { Article(json: $0)! }
    }
}

class Article {
    let author: String
    let title: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    
    required public init?(json: JSON){
        self.author = json["author"].stringValue
        self.title = json["title"].stringValue
        self.url = json["url"].stringValue
        self.urlToImage = json["urlToImage"].stringValue
        self.publishedAt = json["publishedAt"].stringValue
    }
}

