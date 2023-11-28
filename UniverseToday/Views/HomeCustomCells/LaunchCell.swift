//
//  LaunchCell.swift
//  Universe
//
//  Created by 김하연 on 11/24/23.
//

import UIKit

class LaunchCell: UITableViewCell {
    static let id = "LaunchCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rocketName.text = nil
    }
    
    private func configure() {
        image.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [image, rocketName])
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let rocketName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.Fonts.NanumMyeongjoBold, size: 16.0)
        return label
    }()
}
