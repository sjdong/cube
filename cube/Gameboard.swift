//
//  Gameboard.swift
//  cube
//
//  Created by sjdong on 16/2/26.
//  Copyright © 2016年 sjdong@live.com. All rights reserved.
//

import UIKit

/*
* 游戏区域面板
*
* 绘制贪吃蛇爬行区域
* 1. 负责随机插入一个方块
* 2. 移动蛇体
* 3. 负责将吃到的方块添加到该面板上
*/
class GameboardView: UIView {
    var grid: Int
    var gridSize: CGFloat
    var width: CGFloat
    var moveDirect: Direct = Direct.none
    var saveDirect: Direct = Direct.none
    var gridMap: [CubeView]
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not support")
    }
    
    //初始化面板
    init(grid g: Int, gridSize gs: CGFloat, width w: CGFloat) {
        grid = g
        width = w
        gridSize = gs
        gridMap = [CubeView]()
        super.init(frame: CGRectMake(0, 0, w, w))
        let color = HexColor(hex: 0xDDDDDD)
        let lineColor = HexColor(hex: 0xCCCCCC)
        self.backgroundColor = UIColor(red: CGFloat(color.getRed()), green: CGFloat(color.getGreen()), blue: CGFloat(color.getBlue()), alpha: 100)
        self.layer.borderWidth = 1.0
        let borderColor = UIColor(red: CGFloat(lineColor.getRed()), green: CGFloat(lineColor.getGreen()), blue: CGFloat(lineColor.getBlue()), alpha: 100)
        self.layer.borderColor = borderColor.CGColor
        var count = 0
        for row in 0...(grid - 1) {
            let top = CGFloat(row) * gridSize
            for col in 0...(grid - 1) {
                count++
                let left = CGFloat(col) * gridSize
                let cube = CubeView(left: left, top: top, size: gridSize, borderColor: borderColor)
                cube.row = row
                cube.col = col
                gridMap.append(cube)
                self.addSubview(cube)
            }
        }
        setupSwipeController()
    }
    
    func getCube(row: Int, col: Int) -> CubeView {
        return gridMap[row * grid + col]
    }
    
    func getCube(idx: Int) -> CubeView {
        return gridMap[idx]
    }
    
    func updateCube(cube: CubeView, status: CubeStatus, value: Bool) {
        switch status {
        case .isHead:
            cube.isHead = value
        case .isFood:
            cube.isFood = value
        case .inSnake:
            cube.inSnake = value
        }
    }
    
    func getRelateCube(cube: CubeView) -> CubeView? {
        let row = cube.row, col = cube.col, max = grid - 1
        var relateCube: CubeView?
        switch moveDirect {
        case .left:
            relateCube = col! == 0 ? nil : gridMap[row! * grid + col! - 1]
        case .right:
            relateCube = col! == max ? nil : gridMap[row! * grid + col! + 1]
        case .up:
            relateCube = row! == 0 ? nil : gridMap[(row! - 1) * grid + col!]
        case .down:
            relateCube = row! == max ? nil : gridMap[(row! + 1) * grid + col!]
        default:
            relateCube = nil
        }
        saveDirect = moveDirect
        return relateCube
    }
    
    //滑动方向控制
    func setupSwipeController() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("left:"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("right:"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("up:"))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("down:"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.addGestureRecognizer(downSwipe)
    }
    
    //方向控制器
    @objc(left:)
    func leftCommand (r: UIGestureRecognizer) {
        if saveDirect != .right {
            moveDirect = .left
        }
    }
    @objc(right:)
    func rightCommand(r: UIGestureRecognizer) {
        if saveDirect != .left {
            moveDirect = .right
        }
    }
    @objc(down:)
    func downCommand(r: UIGestureRecognizer) {
        if saveDirect != .up {
            moveDirect = .down
        }
    }
    @objc(up:)
    func upCommand(r: UIGestureRecognizer) {
        if saveDirect != .down {
            moveDirect = .up
        }
    }
    
}


