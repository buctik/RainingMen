//
//  GameViewController.swift
//  RainingMen
//
//  Created by Karan Khurana on 6/16/16.
//  Copyright © 2016 Karan Khurana. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var catcherView: UIImageView!
    @IBOutlet weak var cloudView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var highscoreButton: UIButton!
    
    
    var count = 4
    var countMain = 30
    
    var timer: CGFloat!
    var timerMain: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catcherView.alpha = 0
        cloudView.alpha = 0
        timerLabel.alpha = 0
        restartButton.alpha = 0
        highscoreButton.alpha = 0
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        
        
        UIView.animateWithDuration(2, delay: 0, options: [UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
            self.cloudView.center.x = 289
            }) { (Bool) in
                
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMain() {
        if(countMain > 0) {
            countMain = countMain - 1
            timerLabel.text = String(countMain)
            if countMain == 0 {
                countLabel.text = "Game Over"
                catcherView.alpha = 0
                cloudView.alpha = 0
                UIView.animateWithDuration(1, animations: { 
                    self.countLabel.alpha = 1
                    self.restartButton.alpha = 1
                    self.highscoreButton.alpha = 1
                })
                
            }
        }
    }
    
    func update() {
        if(count > 0) {
            count = count - 1
            countLabel.text = String(count)
            if (count == 0) {
                countLabel.text = "Start!"
                UIView.animateWithDuration(1, animations: {
                    self.countLabel.alpha = 0
                    self.catcherView.alpha = 1
                    self.cloudView.alpha = 1
                    self.timerLabel.alpha = 1
                })
            let timerMain = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("updateMain"), userInfo: nil, repeats: true)
            }
        }
    }

    @IBAction func onMoveGIrl(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        
        if point.x > 24 && point.x < 296 {
            catcherView.center.x = point.x
        }
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began")
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture is changing")
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
