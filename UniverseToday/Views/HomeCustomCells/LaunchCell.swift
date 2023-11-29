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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(_ launch: LaunchModel) {
        rocketImage.load(urlString: launch.image)
        rocketName.text = launch.rocketName
        
        contentView.addSubview(stackViewA)
        stackViewA.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }
        
        rocketImage.snp.makeConstraints { make in
            make.width.height.equalTo(stackViewA.snp.width).multipliedBy(0.4)
        }
    }
    
    lazy var stackViewA: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rocketImage, rocketName])
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    lazy var stackViewB: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    let rocketImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    let rocketName = BoldLabel()
    
}
