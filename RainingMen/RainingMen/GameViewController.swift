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
    
    @IBOutlet weak var playerLabel: UILabel!
    
    var count: Int = 0
    var countMain: Int = 0
    
    var score: Int = 33
    
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
//        score = 0
        
        startTimer()
        
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.update), userInfo: nil, repeats: true)
//
//        timerMain = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.updateMain), userInfo: nil, repeats: true)

        
        
        

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
    
    func startTimer() {
        timerLabel.text = "Get Ready"
        count = 4
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameViewController.update), userInfo: nil, repeats: true)
        
        
    }
    
    func stopTimer(){
        timer.invalidate()
    }
    
    func startTimerMain() {
        countMain = 30
        
        timerMain = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GameViewController.updateMain), userInfo: nil, repeats: true)
        
        
        
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

    @IBAction func onMoveGIrl(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
//        var velocity = sender.velocityInView(view)
//        var translation = sender.translationInView(view)
        
        if point.x > 24 && point.x < 296 {
            catcherView.center.x = point.x
        }
        
        
        
//        if (catcherView.center.y <= self.fallingMan.center.y + 42) && (self.fallingMan.center.x - 18 < catcherView.center.x {
//            
//            fallingMan.alpha = 0
//            
//        }
        
        
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
        //prepareForSegue(highScoresSegue, sender: self)
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let leaderboardViewController = segue.destinationViewController as! LeaderboardViewController
        
        //leaderboardViewController.view.layoutIfNeeded()
        
        leaderboardViewController.score1 = score
        leaderboardViewController.playerName = playerLabel.text
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func fallingMen() {
//        print("\(cloudView.center.x)")
        fallingMan = UIImageView(frame: CGRectMake(cloudView.center.x, cloudView.center.y + 36, 36, 36))
        fallingMan.contentMode = UIViewContentMode.ScaleAspectFill
        
        
        fallingMan.image = menImages[0]
        
        fallingMan.alpha = 1
        
        self.view.addSubview(fallingMan)
        
        UIView.animateWithDuration(3) {
            self.fallingMan.center.y = 568
        }
        
//        let cloudCenter = cloudView.center.x
//        fallingMan.center.x = cloudCenter
//        fallingMan.center.y = cloudView.center.y + 36
        
        
    }
    

}
