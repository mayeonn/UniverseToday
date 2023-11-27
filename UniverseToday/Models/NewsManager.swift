//
//  NewsManager.swift
//  Universe
//
//  Created by 김하연 on 11/21/23.
//

import Foundation

protocol NewsManagerDelegate {
    func newsLoaded()
}

class NewsManager {
    var news = [NewsModel]()
    var delegate: NewsManagerDelegate?
    
    func performRequest() {
        if let url = URL(string: K.newsURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let decodeData = try decoder.decode(NewsData.self, from: safeData)
                            self.news = decodeData.results
                            self.delegate?.newsLoaded()
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
