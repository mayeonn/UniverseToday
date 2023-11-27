//
//  APODnetworking.swift
//  Universe
//
//  Created by 김하연 on 11/18/23.
//

import Foundation

struct APODnetworking {
    let apodurl = "https://api.nasa.gov/planetary/apod?api_key=e6HkIu8DYUh52ULpsMXBeRcrtYsxHAEBPTaeDPtM"
     
    func performRequest() {
        if let url = URL(string: apodurl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    if let apod = self.parseJSON(safeData){
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ apodData: Data) -> APODModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(APOD.self, from: apodData)
            let url: String = decodeData.url
            let title: String = decodeData.title
            let explanation: String = decodeData.explanation
            let APODmodel = APODModel(url: url, title: title, explanation: explanation)
            return APODmodel
        } catch {
            print(error)
            return nil
        }
    }
}
