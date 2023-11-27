//
//  NewsDetailViewController.swift
//  UniverseToday
//
//  Created by 김하연 on 11/28/23.
//
import WebKit
import UIKit

class NewsDetailViewController: UIViewController {
    let newsUrl: String
    let webView = WKWebView()
    
    init(newsUrl: String) {
        self.newsUrl = newsUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: newsUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
