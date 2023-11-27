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
}
