//
//  APODmanager.swift
//  Universe
//
//  Created by 김하연 on 11/21/23.
//

import Foundation
import UIKit

class APODmanager {
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.Fonts.NanumMyeongjoBold, size: 16.0)
        return label
    }()
    let explanationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.Fonts.NanumMyeongjoRegular, size: 14.0)
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    func performRequest(imageWidth: CGFloat){
        if let url = URL(string: K.apodURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let safeData = data {
                    if let apod = self.parseJSON(safeData) {
                        
                        let ratio = self.imageDimenssions(url: apod.url)
                        
                        
                        DispatchQueue.main.async {
                            self.imageView.snp.makeConstraints { make in
                                make.height.equalTo(imageWidth * ratio).priority(999)
                            }
                            
                            self.titleLabel.text = apod.title
                            self.explanationLabel.text = apod.explanation
                            self.imageView.load(urlString: apod.url)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(K.loaded), object: nil)
                        }
                    }
                }
                else if let error = error {
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ apodData: Data) -> ApodModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(APOD.self, from: apodData)
            let title = decodeData.title
            let explanation = decodeData.explanation
            let url = decodeData.url
            
            let apod = ApodModel(url: url, title: title, explanation: explanation)
            return apod
        } catch {
            print(error)
            return nil
        }
    }
            
    
    func imageDimenssions(url: String) -> CGFloat {
        if let imageSource = CGImageSourceCreateWithURL(URL(string: url)! as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! CGFloat
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! CGFloat
                return pixelHeight / pixelWidth
            }
        }
        return 1.0
    }
}


extension UIImageView {
    func load(urlString: String){
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
