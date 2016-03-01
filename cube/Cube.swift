//
//  Cube.swift
//  cube
//
//  Created by sjdong on 16/2/26.
//  Copyright © 2016年 sjdong@live.com. All rights reserved.
//

import UIKit

//方块视图，描述地图以及蛇体
class CubeView: UIView {
    //方块所在的行和列
    var row: Int?, col: Int?
    //是否是数组第一个方块
    var isHead: Bool = false {
        willSet {
            if newValue {
                self.backgroundColor = UIColor.orangeColor()
            } else if inSnake {
                self.backgroundColor = UIColor.blackColor()
            } else {
                self.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    var inSnake: Bool = false {
        willSet {
            if !isHead && newValue {
                self.backgroundColor = UIColor.blackColor()
            } else if !newValue {
                self.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    var isFood: Bool = false {
        willSet {
            if newValue {
                self.backgroundColor = UIColor.blackColor()
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not support")
    }
    init(left: CGFloat, top: CGFloat, size: CGFloat, borderColor: UIColor) {
        super.init(frame: CGRectMake(left, top, size, size))
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = 0.5
    }
    
}
