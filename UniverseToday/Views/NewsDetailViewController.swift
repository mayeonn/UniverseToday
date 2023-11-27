//
//  NewsDetailViewController.swift
//  UniverseToday
//
//  Created by 김하연 on 11/28/23.
//
import Foundation
import UIKit

class NewsDetailViewController: UIViewController {
    private let label: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    init(newsUrl: String) {
        label.text = newsUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.width.height.equalTo(view)
        }
    }
}
