//
//  EditCategoryCell.swift
//  Universe
//
//  Created by 김하연 on 11/14/23.
//
import UIKit
import SnapKit

protocol EditCategoryCellDelegate {
    func addCategory(_ id: Int)
    func deleteCategory(_ id: Int)
}

class EditCategoryCell: UITableViewCell {
    static let id = "EditCategoryCell"

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var categoryId = 0
    let title = UILabel()
    let checkBox = UIButton()
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [checkBox, title])
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    var cellDelegate: EditCategoryCellDelegate?
    
    private func setStack() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(20)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    func setSection(_ section: Int) {
        let imageName: String
        if section == 0 {
            imageName = "checkmark.square"
            checkBox.addTarget(self, action: #selector(uncheck), for: .touchUpInside)
        } else {
            imageName = "square"
            checkBox.addTarget(self, action: #selector(check), for: .touchUpInside)
        }
        checkBox.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc func check() {
        cellDelegate?.addCategory(categoryId)
    }
    @objc func uncheck() {
        cellDelegate?.deleteCategory(categoryId)
    }
}
