//
//  ViewController.swift
//  cube
//
//  Created by sjdong on 16/2/25.
//  Copyright © 2016年 sjdong@live.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStart()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupStart() {
        let bounds: CGRect = self.view.bounds
        let button: UIButton = UIButton()
        button.setTitle("start game", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRectMake((bounds.width - 120) / 2, (bounds.height - 40) / 2, 120, 40)
        button.addTarget(self, action: "startGame:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    func startGame(sender: UIButton) {
        let game = SnakeGameViewController(grid: 20)
        self.presentViewController(game, animated: true, completion: nil)
    }

}

