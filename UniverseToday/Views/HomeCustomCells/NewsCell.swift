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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        site.text = nil
        title.text = nil
    }
    
    
    private func configure() {
        contentView.addSubview(site)
        site.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(12)
            make.left.right.equalTo(contentView).inset(20)
        }
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(site.snp.bottom).offset(4)
            make.left.right.equalTo(contentView).inset(28)
            make.bottom.equalTo(contentView).inset(12)
        }
    }
    
    
    
    let site: SmallLabel = {
        let label = SmallLabel()
        label.backgroundColor = .systemGray5
        return label
    }()
    let title: BoldLabel = {
        let label = BoldLabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.isUserInteractionEnabled = true
        return label
    }()
}
