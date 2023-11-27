//
//  HomeCategoryFooter.swift
//  Universe
//
//  Created by 김하연 on 11/27/23.
//
import UIKit
import SnapKit

class HomeCategoryFooter: UITableViewHeaderFooterView {
    static let id = "HomeCategoryFooter"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    let phrase: UILabel = {
        let label = UILabel()
        label.text = K.editCategoryPhrase
        label.font = UIFont(name: K.Fonts.NanumMyeongjoRegular, size: 16.0)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    let editButton: UIButton = {
        let btn = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        btn.setImage(UIImage(systemName: K.editCategoryButton, withConfiguration: imageConfig), for: .normal)
        btn.tintColor = .systemIndigo
        return btn
    }()
    
    
    func configure() {
        let stackView = UIStackView(arrangedSubviews: [phrase, editButton])
        stackView.axis = .horizontal
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(100)
            make.bottom.left.right.equalTo(contentView).inset(32)
        }
    }
}
