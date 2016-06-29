//
//  GameViewController.swift
//  RainingMen
//
//  Created by Karan Khurana on 6/16/16.
//  Copyright © 2016 Karan Khurana. All rights reserved.
//

import UIKit
import QuartzCore

class GameViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var catcherView: UIImageView!
    @IBOutlet weak var cloudView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var highscoreButton: UIButton!
    
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var playerLabel: UILabel!
    
    var count: Int = 0
    var countMain: Int = 0
    
    var score: Int = 0
    
    var timer: NSTimer!
    var timerMain: NSTimer!
    
    var player: String!
    
    var fallingMan: UIImageView!
    
    var menImages: [UIImage] = [
    
        UIImage(named: "falling_man")!
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerLabel.text = player
        
        playerLabel.alpha = 0
        catcherView.alpha = 0
        cloudView.alpha = 0
        timerLabel.alpha = 0
        restartButton.alpha = 0
        highscoreButton.alpha = 0
        scoreTitleLabel.alpha = 0
        scoreLabel.alpha = 0
        
        startTimer()
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
    
    
    
    
    func startTimer() {
        timerLabel.text = "Get Ready"
        count = 4
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.update), userInfo: nil, repeats: true)
        
        
    }
    
    func stopTimer(){
        timer.invalidate()
    }
    
    func startTimerMain() {
        countMain = 300
        
        timerMain = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(GameViewController.updateMain), userInfo: nil, repeats: true)
    }
    
    func stopTimerMain(){
        timerMain.invalidate()
    }
    
    func update() {
        if(count > 0) {
            count = count - 1
            countLabel.text = String(count)
            if (count == 0) {
                countMain = 30
                countLabel.text = "Start!"
                UIView.animateWithDuration(1, animations: {
                    self.playerLabel.alpha = 1
                    self.countLabel.alpha = 0
                    self.catcherView.alpha = 1
                    self.cloudView.alpha = 1
                    self.timerLabel.alpha = 1
                    self.scoreTitleLabel.alpha = 1
                    self.scoreLabel.alpha = 1
                })
                stopTimer()
                startTimerMain()
                
                fallingMen()
                
                UIView.animateWithDuration(2, delay: 0, options: [UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
                    self.cloudView.center.x = 289
                }) { (Bool) in
                    
                }
                
            }
        }
    }
    
    func updateMain() {
        if(countMain > 0) {
            if (catcherView.center.y <= self.fallingMan.layer.presentationLayer()!.frame.origin.y + 42) && ((self.fallingMan.layer.presentationLayer()!.frame.origin.x + 18 > catcherView.center.x - 24 && self.fallingMan.layer.presentationLayer()!.frame.origin.x + 18 < catcherView.center.x + 24) || (self.fallingMan.layer.presentationLayer()!.frame.origin.x - 18 < catcherView.center.x + 24 && self.fallingMan.layer.presentationLayer()!.frame.origin.x > catcherView.center.x - 24)) {
                
                fallingMan.alpha = 0
                fallingMan.frame.origin.y = 0
                score += 1
                scoreLabel.text = String(score)
                
            }
            countMain = countMain - 1
            timerLabel.text = String(Int(countMain/10))
            if countMain == 0 {
                countLabel.text = "Game Over"
                catcherView.alpha = 0
                cloudView.alpha = 0
                scoreTitleLabel.alpha = 0
                scoreLabel.alpha = 0
                timerLabel.alpha = 0
                self.playerLabel.alpha = 0
                UIView.animateWithDuration(1, animations: {
                    self.countLabel.alpha = 1
                    self.restartButton.alpha = 1
                    self.highscoreButton.alpha = 1
                    
                })
                stopTimerMain()
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
        
//        if sender.state == UIGestureRecognizerState.Began {
//            print("Gesture began")
//        } else if sender.state == UIGestureRecognizerState.Changed {
//            print("Gesture is changing")
//        } else if sender.state == UIGestureRecognizerState.Ended {
//            print("Gesture ended")
//        }
    }
    @IBAction func tappedHighScoresButton(sender: UIButton) {
        performSegueWithIdentifier("highScoresSegue", sender: self)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let leaderboardViewController = segue.destinationViewController as! LeaderboardViewController
        
        leaderboardViewController.score1 = score
        leaderboardViewController.playerName = playerLabel.text
    }
    
    func fallingMen() {
        fallingMan = UIImageView(frame: CGRectMake(cloudView.center.x, cloudView.center.y + 36, 36, 36))
        fallingMan.contentMode = UIViewContentMode.ScaleAspectFill
        
        
        fallingMan.image = menImages[0]
        
        fallingMan.alpha = 1
        
        self.view.insertSubview(fallingMan, belowSubview: catcherView)
        
        UIView.animateWithDuration(3) {
            self.fallingMan.center.y = 568
        }
        
        
    }
    

}
