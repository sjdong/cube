//
//  Fieldmodels.swift
//  cube
//
//  Created by sjdong on 16/2/26.
//  Copyright © 2016年 sjdong@live.com. All rights reserved.
//

import Foundation

//移动方向
enum Direct {
    case up, down, left, right, none
}
enum CubeStatus {
    case isFood, inSnake, isHead
}
//移动状态
struct MoveAction {
    var direction: Direct = Direct.down
    private var next: Direct?
    var finish: Bool = false {
        willSet {
            if newValue {
                self.next = nil
            }
        }
    }
    
}

struct RoundLink {
    var left: CubeView?
    var right: CubeView?
    var top: CubeView?
    var down: CubeView?
}

class HexColor {
    var hex: Int32
    init (hex h: Int32) {
        hex = h
    }
    
    func getRed() -> Float{
        return Float((hex & 0xFF0000) >> 16) / 255.0
    }
    func getGreen() -> Float {
        return Float((hex & 0x00FF00) >> 8) / 255.0
    }
    func getBlue() -> Float {
        return Float(hex & 0x0000FF) / 255.0
    }
}

struct SquareGameboard<T> {
    let grid : Int
    var boardArray : [T]
    
    init(grid d: Int, initValue value: T?) {
        grid = d
        boardArray = [T](count:d*d, repeatedValue: value!)
    }
    
    subscript(row: Int, col: Int) -> T {
        get {
            assert(row >= 0 && row < grid)
            assert(col >= 0 && col < grid)
            return boardArray[row*grid + col]
        }
        set {
            assert(row >= 0 && row < grid)
            assert(col >= 0 && col < grid)
            boardArray[row*grid + col] = newValue
        }
    }
    
    mutating func setAll(item: T) {
        for i in 0..<grid {
            for j in 0..<grid {
                self[i, j] = item
            }
        }
    }
}