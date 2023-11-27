//
//  NewsCell.swift
//  Universe
//
//  Created by 김하연 on 11/24/23.
//

import UIKit

class NewsCell: UITableViewCell {
    static let id = "NewsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(site)
        site.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(12)
        }
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(site.snp.bottom).offset(4)
            make.left.right.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(12)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        site.text = "nil"
        title.text = "nil"
//        self.setNeedsLayout()
    }
    
    let site: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .systemGray5
        label.font = UIFont(name: K.Fonts.NanumMyeongjoRegular, size: 14.0)
        return label
    }()
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.font = UIFont(name: K.Fonts.NanumMyeongjoBold, size: 16.0)
        return label
    }()
}
