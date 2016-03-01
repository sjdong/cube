//
//  SnakeGame.swift
//  cube
//
//  Created by sjdong on 16/2/25.
//  Copyright © 2016年 sjdong@live.com. All rights reserved.
//

import UIKit

class SnakeGameViewController: UIViewController, GameModelProtocol {
    //格子数量
    var grid: Int
    //游戏面板
    var board: GameboardView?
    var score: ScoreView?
    var model: GameModel?
    var timer: NSTimer?
    var speed: CGFloat = 0.5
    let margin: CGFloat = 20
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not support Error")
    }
    
    init(grid d: Int) {
        grid = d > 30 ? 30 :  (d < 8 ? 8 : d)
        super.init(nibName: nil, bundle: nil)
        model = GameModel(grid: grid, delegate: self)
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    
    //创建游戏
    func setupGame() {
        let vWidth = view.bounds.width
        let vHeight = view.bounds.height
        
        func xToCenter(v: UIView) -> CGFloat {
            let width = v.bounds.width
            let xpos = 0.5 * (vWidth - width)
            return xpos >= 0 ? xpos : 0
        }
        
        let width: CGFloat = view.bounds.width - 2 * margin
        let size: CGFloat = width / CGFloat(grid)
        let gameboard = GameboardView(grid: grid, gridSize: size, width: width)
        let scoreView = ScoreView()
        scoreView.score = 0
        let totalHeight = scoreView.bounds.height + 20 + gameboard.bounds.height
        let top = 0.5 * (vHeight - totalHeight)
        
        var f = gameboard.frame
        f.origin.x = xToCenter(gameboard)
        f.origin.y = top + scoreView.bounds.height + 20
        gameboard.frame = f
        f = scoreView.frame
        f.origin.x = xToCenter(scoreView)
        f.origin.y = top
        scoreView.frame = f
        
        view.addSubview(gameboard)
        view.addSubview(scoreView)
        board = gameboard
        self.score = scoreView
        //开始游戏
        assert(model != nil)
        let m = model!
        let b = board!
        let first = b.getCube(grid / 2, col: grid / 2)
        m.insertSnakeCube(first, index: 0)
        m.insertRandomCube(0)
        b.updateCube(first, status: CubeStatus.isHead, value: true)
        b.moveDirect = Direct.down
        start()
    }
    
    func reset() {
        model!.reset()
        
    }
    
    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(speed), target: self, selector: "move:", userInfo: nil, repeats: true)
    }
    
    
    func move(sender: NSTimer) {
        model!.moveSnake(nil, tail: nil)
    }
    
    func updateSpeed() {
        let cur = score!.score
        if (cur < 5 && cur % 5 != 0) { return }
        
        speed *= 0.9
        if speed <= 0.04 {
            speed = 0.04
        }
        timer!.invalidate()
        start()
    }
    
    //protocol
    func moveSnake(head: CubeView, tail: CubeView) {
        let b = board!
        let m = model!
        b.updateCube(head, status: CubeStatus.isHead, value: false)
        b.updateCube(head, status: CubeStatus.inSnake, value: true)
        let newHead = b.getRelateCube(head)
        if newHead == nil || newHead!.inSnake {
            let alert = UIAlertController(title: "游戏结束", message: "游戏结束你的得分为\(score!.score)分", preferredStyle: UIAlertControllerStyle.Alert)
            let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(cancel)
            self.presentViewController(alert, animated: true, completion: nil)
            timer!.invalidate()
        } else {
            b.updateCube(newHead!, status: CubeStatus.isHead, value: true)
            m.insertSnakeCube(newHead!, index: 0)
            if !newHead!.isFood {
                m.removeTail()
                b.updateCube(tail, status: CubeStatus.inSnake, value: false)
            } else {
                newHead!.isFood = false
                m.insertRandomCube(0)
                score!.score++
                updateSpeed()
            }
        }
    }
    
    func insertRandomCube(idx: Int) {
        let b = board!
        let cube = b.getCube(idx)
        b.updateCube(cube, status: CubeStatus.isFood, value: true)
    }
    
    
    
}