//
//  ShowUIViewController.swift
//  LearningUIkitApp
//
//  Created by qian tao on 16/1/9.
//  Copyright © 2016年 qian tao. All rights reserved.
//

import UIKit

class ShowUIViewController: UIViewController {
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.orangeColor()
        let contentText = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        contentText.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        contentText.text = "This is a UIView"
        contentText.textAlignment = .Center
        contentText.textColor = UIColor.whiteColor()
        contentText.minimumScaleFactor = 2.0

        self.view.addSubview(contentText)
    }
}
