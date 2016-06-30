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
    
    var fallingMan: [UIImageView] = []
    var fallingManView: UIImageView!
    
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
            
        }
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
            
            //                fallingMen()
            
            UIView.animateWithDuration(2, delay: 0, options: [UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
                self.cloudView.center.x = 289
            }) { (Bool) in
                
            }
            
        }
    }
    
    func updateMain() {
        print("\(countMain)")
        if countMain % 300 == 0 {
            fallingMen()
        }
        countMain = countMain - 1
        timerLabel.text = String(Int(countMain/10))
        if countMain > 0 && countMain < 299 {
            let fallingManLength = fallingMan.count-1
            for n in 0...fallingManLength{
                let catcherViewLeftEdge = catcherView.frame.origin.x
                let catcherViewRightEdge = catcherView.frame.origin.x + catcherView.frame.width
                let catcherViewTopEdge = catcherView.frame.origin.y
                
                //            print("\(fallingMan.layer.presentationLayer()!.frame.origin.y,fallingMan.alpha, self.catcherView.frame.origin.y)")
                print("\(countMain/10,n,fallingMan)")
                let fallingManLeftEdge = fallingMan[n].layer.presentationLayer()!.frame.origin.x
                let fallingManRightEdge = fallingMan[n].layer.presentationLayer()!.frame.origin.x + fallingMan[n].layer.presentationLayer()!.frame.width
                let fallingManBottomEdge = fallingMan[n].layer.presentationLayer()!.frame.origin.y + fallingMan[n].layer.presentationLayer()!.frame.height
                
                if (catcherViewTopEdge <= fallingManBottomEdge) && ((fallingManRightEdge > catcherViewLeftEdge && fallingManRightEdge < catcherViewRightEdge) || (fallingManLeftEdge < catcherViewRightEdge && fallingManLeftEdge > catcherViewLeftEdge)) {
                    fallingMan[n].alpha = 0
                    fallingMan[n].center.y = 0
                    score += 1
                    scoreLabel.text = String(score)
                    
                }
            }
            
            
            
            
        }
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
        fallingManView = UIImageView(frame: CGRectMake(cloudView.layer.presentationLayer()!.frame.origin.x, cloudView.layer.presentationLayer()!.frame.origin.y + 36, 36, 36))
        fallingManView.contentMode = UIViewContentMode.ScaleAspectFill
        
        fallingManView.image = menImages[0]
        
        fallingManView.alpha = 1
        fallingMan.append(fallingManView)
        self.view.insertSubview(fallingManView, belowSubview: catcherView)
        
        UIView.animateWithDuration(3) {
            self.fallingManView.frame.origin.y = 568
        }
        
        
    }
    

}
