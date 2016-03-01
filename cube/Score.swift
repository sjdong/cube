
//
//  Score.swift
//  cube
//
//  Created by sjdong on 16/2/26.
//  Copyright © 2016年 sjdong@live.com. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    var score: Int = 0 {
        didSet {
            scorePanel.text = "当前得分:\(score)"
        }
    }
    var scorePanel: UILabel
    let defaultFrame = CGRectMake(0, 0, 140, 80)
    
    required init(coder aDecoder: NSCoder) {
        fatalError("请初始化ScoreView")
    }
    init() {
        scorePanel = UILabel()
        super.init(frame: defaultFrame)
        scorePanel.textAlignment = NSTextAlignment.Center
        scorePanel.textColor = UIColor.blackColor()
        scorePanel.frame = defaultFrame
        scorePanel.font = UIFont(name: "Consolas", size: 40)
        self.addSubview(scorePanel)
    }
    
    func setScore(newScore s: Int) {
        score = s
    }
    
}
