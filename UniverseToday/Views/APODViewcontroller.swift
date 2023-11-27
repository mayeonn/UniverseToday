//
//  APODViewcontroller.swift
//  Universe
//
//  Created by 김하연 on 11/16/23.
//

import UIKit
import SnapKit



class APODViewController: UIViewController {
    var delegate: APODmanagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performRequest()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view).inset(8)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.right.equalTo(view).inset(12)
        }
        view.addSubview(explanationLabel)
        explanationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(view).inset(12)
        }
    }
    

    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.Fonts.NanumMyeongjoBold, size: 16.0)
        return label
    }()
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.Fonts.NanumMyeongjoRegular, size: 14.0)
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    
    func performRequest(){
        if let url = URL(string: K.apodURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let safeData = data {
                    if let apod = self.parseJSON(safeData) {
                        
                        let ratio = self.imageDimenssions(url: apod.url)
                        
                        
                        DispatchQueue.main.async {
                            let width = self.view.bounds.width * 0.84
                            self.imageView.snp.makeConstraints { make in
                                make.height.equalTo(width*ratio)
                            }
                            
                            self.titleLabel.text = apod.title
                            self.explanationLabel.text = apod.explanation
                            self.imageView.load(urlString: apod.url)
                            
                            self.delegate?.loaded()
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


