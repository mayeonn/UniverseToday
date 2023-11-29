//
//  HomeViewCell.swift
//  Universe
//
//  Created by 김하연 on 11/15/23.
//

import UIKit
import SnapKit

class HomeCategoryHeader: UITableViewHeaderFooterView {
    static let id = "HomeCategoryHeader"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        title.text = nil
        subTitle.text = nil
    }

    let title: BoldLabel = {
        let label = BoldLabel()
        label.font = label.font.withSize(28)
        return label
    }()
    let subTitle: RegularLabel = {
        let label = RegularLabel()
        return label
    }()
    
    func configure() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(12)
            make.left.right.equalTo(contentView).inset(8)
        }
        contentView.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.left.right.equalTo(contentView).inset(8)
            make.bottom.equalTo(contentView)
        }
    }
}
