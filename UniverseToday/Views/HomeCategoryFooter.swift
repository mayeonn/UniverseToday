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

    let phrase: RegularLabel = {
        let label = RegularLabel()
        label.text = K.editCategoryPhrase
        label.textColor = .gray
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
            make.top.bottom.equalTo(contentView).offset(28)
            make.left.right.equalTo(contentView).inset(20)
        }
    }
}
