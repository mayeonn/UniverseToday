//
//  ViewController.swift
//  Universe
//
//  Created by 김하연 on 11/11/23.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            let topMargin = UIScreen.main.bounds.height/3
            make.top.equalTo(self.view).offset(topMargin)
        }
        
        let delay: Double = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        }
    }
    
    
    private let backgroundImage: UIImageView = {
        let background = UIImageView(frame: UIScreen.main.bounds)
        background.image = UIImage(named: "milkyway")
        background.contentMode = .scaleAspectFill
        return background
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = K.onboardingMessage
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 36)
        title.textAlignment = .center
        return title
    }()
}
