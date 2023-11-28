//
//  NewsModel+data.swift
//  Universe
//
//  Created by 김하연 on 11/21/23.
//

import Foundation

struct NewsData: Decodable {
    let results: [NewsModel]
}

struct NewsModel: Decodable {
    let title: String
    let url: String?
    let news_site: String
}
