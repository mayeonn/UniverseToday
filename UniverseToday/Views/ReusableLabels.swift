//
//  ReusableLabels.swift
//  UniverseToday
//
//  Created by 김하연 on 11/30/23.
//

import UIKit

class BoldLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: K.Fonts.NanumMyeongjoBold, size: 16.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class RegularLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: K.Fonts.NanumMyeongjoRegular, size: 16.0)
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class SmallLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: K.Fonts.NanumMyeongjoRegular, size: 14.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
