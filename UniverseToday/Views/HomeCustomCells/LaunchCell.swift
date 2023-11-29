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
        rocketName.setTextWithLineHeight(text: launch.rocketName, lineHeight: 24)
        agency.text = launch.agency
        mission.text = launch.mission
        time.setTextWithLineHeight(text: launch.time, lineHeight: 40)
        time.textColor = .darkGray
        padName.text = launch.padName
        padLocation.text = launch.padLocation
        
        rocketImage.snp.makeConstraints { make in
            make.width.height.equalTo(stackViewA.snp.width).multipliedBy(0.4)
        }
        contentView.addSubview(stackViewA)
        stackViewA.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(8)
        }

    }
    
    lazy var stackViewA: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rocketImage, stackViewB])
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    lazy var stackViewB: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rocketName, agency, mission, time, padLocation, padName])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.layoutMargins = UIEdgeInsets(top: 12, left: .zero, bottom: 4, right: .zero)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let rocketImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    let rocketName = BoldLabel()
    let agency = SmallLabel()
    let mission = SmallLabel()
    let time = BoldLabel()
    let padName = SmallLabel()
    let padLocation = SmallLabel()
}

extension UILabel {
     func setTextWithLineHeight(text: String?, lineHeight: CGFloat){
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight

            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 2
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
