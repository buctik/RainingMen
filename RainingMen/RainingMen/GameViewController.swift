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
    
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var count: Int = 0
    var countMain: Int = 0
    
    var timer: CGFloat!
    var timerMain: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catcherView.alpha = 0
        cloudView.alpha = 0
        timerLabel.alpha = 0
        restartButton.alpha = 0
        highscoreButton.alpha = 0
        scoreTitleLabel.alpha = 0
        scoreLabel.alpha = 0
        
        startTimer()
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.update), userInfo: nil, repeats: true)

        let timerMain = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.updateMain), userInfo: nil, repeats: true)

        
        
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
    
    
    @IBAction func onRestart(sender: AnyObject) {
        startTimer()
        restartButton.alpha = 0
        highscoreButton.alpha = 0
    }
    
    
    
    func updateMain() {
        if(countMain > 0) {
            countMain = countMain - 1
            timerLabel.text = String(countMain)
            if countMain == 0 {
                countLabel.text = "Game Over"
                catcherView.alpha = 0
                cloudView.alpha = 0
                scoreTitleLabel.alpha = 0
                scoreLabel.alpha = 0
                timerLabel.alpha = 0
                UIView.animateWithDuration(1, animations: {
                    self.countLabel.alpha = 1
                    self.restartButton.alpha = 1
                    self.highscoreButton.alpha = 1
                    
                })
                stopTimerMain()
            }
        }
    }
    
    func startTimer() {
        timerLabel.text = "Get Ready"
        count = 4
//        let timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.update), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
//        timer.invalidate()
    }
    
    func startTimerMain() {
        countMain = 30
//        let timerMain = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.updateMain), userInfo: nil, repeats: true)
    }
    
    func stopTimerMain(){
//        timerMain.invalidate()
    }
    
    func update() {
        if(count > 0) {
            count = count - 1
            countLabel.text = String(count)
            if (count == 0) {
                countMain = 30
                countLabel.text = "Start!"
                UIView.animateWithDuration(1, animations: {
                    self.countLabel.alpha = 0
                    self.catcherView.alpha = 1
                    self.cloudView.alpha = 1
                    self.timerLabel.alpha = 1
                    self.scoreTitleLabel.alpha = 1
                    self.scoreLabel.alpha = 1
                })
                stopTimer()
                startTimerMain()
            }
        }
    }

    @IBAction func onMoveGIrl(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
//        var velocity = sender.velocityInView(view)
//        var translation = sender.translationInView(view)
        
        
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
