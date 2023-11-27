//
//  ApodCell.swift
//  Universe
//
//  Created by 김하연 on 11/24/23.
//

import UIKit

class ApodCell: UITableViewCell {
    static let id = "ApodCell"
    let apodManager = APODmanager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        apodManager.performRequest(imageWidth: contentView.frame.size.width)
        configure()
        NotificationCenter.default.addObserver(self, selector: #selector(loaded), name: NSNotification.Name(K.loaded), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.setNeedsLayout()
    }
    
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [apodManager.imageView, apodManager.titleLabel, apodManager.explanationLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    @objc func loaded() {
        self.setNeedsLayout()
    }
}
