//
//  GameModel.swift
//  cube
//
//  Created by sjdong on 16/2/29.
//  Copyright © 2016年 sjdong@live.com. All rights reserved.
//

import UIKit
protocol GameModelProtocol: class {
    func insertRandomCube(idx: Int)
    func moveSnake(head: CubeView, tail: CubeView)
}

class GameModel: NSObject {
    var grid: Int
    var snake: [CubeView]
    var mapSubscript: Set<Int> = []
    var snakeSubscript: Set<Int> = []
    unowned let delegate : GameModelProtocol
    
    init(grid g: Int, delegate d: GameModelProtocol) {
        grid = g
        delegate = d
        snake = [CubeView]()
        super.init()
        for row in 0 ... (grid * grid - 1) {
            mapSubscript.insert(row)
        }
    }
    
    func insertSnakeCube(cube: CubeView, index: Int?) {
        snakeSubscript.insert(cube.row! * grid + cube.col!)
        if index == nil {
            snake.append(cube)
        } else {
            snake.insert(cube, atIndex: index!)
        }
    }
    
    func removeTail() {
        let last = snake.last
        snakeSubscript.remove(last!.row! * grid + last!.col!)
        snake.removeLast()
    }
    
    func reset() {
        snake.removeAll()
        snakeSubscript.removeAll()
    }
    
    //代理实现
    /**
    * 随机插入一个方块实质是将一个方块状态改变
    * @params {int} x
    * @params {int} y
    */
    func insertRandomCube(idx: Int) {
        let newMap = mapSubscript.exclusiveOr(snakeSubscript)
        let random = Int(arc4random_uniform(UInt32(newMap.count)))
        let idx = newMap[newMap.startIndex.advancedBy(random)]
        delegate.insertRandomCube(idx)
    }
    
    func moveSnake(head: CubeView?, tail: CubeView?) {
        let h = snake.first, l = snake.last
        delegate.moveSnake(h!, tail: l!)
    }
    
}
