//
//  GameViewController.swift
//  RainingMen
//
//  Created by Karan Khurana on 6/16/16.
//  Copyright © 2016 Karan Khurana. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var catcherView: UIImageView!
    @IBOutlet weak var cloudView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var highscoreButton: UIButton!
    @IBOutlet weak var changeNameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var minusOneLabel: UILabel!
    
    @IBOutlet weak var playerLabel: UILabel!
    
    var backgroundMusicPlayer: AVAudioPlayer!
    
    
    var count: Int = 0
    var countMain: Int!
    
    var score: Int = 0
    
    var timer: NSTimer!
    var timerMain: NSTimer!
    
    var player: String!
    
    var fallingMan: [UIImageView] = []
    var fallingManView: UIImageView!
    
    var menImages: [UIImage] = [
    
        UIImage(named: "falling_man")!
        
    ]
    
    //Game Mechanics
    var timeToFall: NSTimeInterval = 2 //in seconds
    var cloudSpeedOneWay: NSTimeInterval = 1 //in seconds
    var dropInterval: Int = 2 //in seconds
    var levelTimerLength: Int = 30 //in seconds
    var levelTimerSpeed: Int = 5 //Speed from 1 - 10  with 1 beeing normal speed and 10 being super fast
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerLabel.text = player
        
        playerLabel.alpha = 0
        catcherView.alpha = 0
        cloudView.alpha = 0
        timerLabel.alpha = 0
        restartButton.alpha = 0
        highscoreButton.alpha = 0
        changeNameButton.alpha = 0
        settingsButton.alpha = 0
        scoreTitleLabel.alpha = 0
        scoreLabel.alpha = 0
        minusOneLabel.alpha = 0
        
        playBackgroundMusic()
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onRestart(sender: AnyObject) {
        restartButton.alpha = 0
        highscoreButton.alpha = 0
        changeNameButton.alpha = 0
        settingsButton.alpha = 0
        score = 0
        scoreLabel.text = String(score)
        startTimer()
    }
    
    
    
    
    func startTimer() {
        timerLabel.text = "Get Ready"
        count = 4
        backgroundMusicPlayer.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(GameViewController.update), userInfo: nil, repeats: true)
        
        
    }
    
    func stopTimer(){
        countLabel.text = "Start!"
        UIView.animateWithDuration(0.5, animations: {
            self.playerLabel.alpha = 1
            self.countLabel.alpha = 0
            self.catcherView.alpha = 1
            self.cloudView.alpha = 1
            self.timerLabel.alpha = 1
            self.scoreTitleLabel.alpha = 1
            self.scoreLabel.alpha = 1
        })
        timer.invalidate()
        startTimerMain()
    }
    
    func startTimerMain() {
        countMain = levelTimerLength * 10
        cloudView.center.x = 31
        UIView.animateWithDuration(cloudSpeedOneWay, delay: 0, options: [UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse], animations: {
            self.cloudView.center.x = 289
        }) { (Bool) in
            
        }
        
        cloudView.startAnimating()
        
        timerMain = NSTimer.scheduledTimerWithTimeInterval((0.1 / Double(levelTimerSpeed)), target: self, selector: #selector(GameViewController.updateMain), userInfo: nil, repeats: true)
    }
    
    func stopTimerMain(){
        countLabel.text = "Game Over"
        catcherView.alpha = 0
        cloudView.alpha = 0
        scoreTitleLabel.alpha = 0
        scoreLabel.alpha = 0
        minusOneLabel.alpha = 0
        timerLabel.alpha = 0
        self.playerLabel.alpha = 0
        UIView.animateWithDuration(1, animations: {
            self.countLabel.alpha = 1
            self.restartButton.alpha = 1
            self.highscoreButton.alpha = 1
            self.changeNameButton.alpha = 1
            self.settingsButton.alpha = 1
        })
        fallingMan = []
        cloudView.stopAnimating()
        timerMain.invalidate()
        backgroundMusicPlayer.stop()
        backgroundMusicPlayer.currentTime = 0
    }
    
    func update() {
        if(count > 0) {
            count = count - 1
            countLabel.text = String(count)
        }
        if (count == 0) {
            stopTimer()
        }
    }
    
    func updateMain() {
        if countMain % (dropInterval * 10) == 0 {
            fallingMen()
        }
        
        if countMain < 0 {
            countMain = 0
        }
        timerLabel.text = String(Int(countMain/10))
        
        let fallingManLength = fallingMan.count-1
        if countMain >= 0 {
            countMain = countMain - 1
            if  fallingMan[fallingManLength].alpha == 0 {
                stopTimerMain()
            }
            if fallingMan.count > 0 {
                
                for n in 0...fallingManLength{
                    let catcherViewLeftEdge = catcherView.frame.origin.x
                    let catcherViewRightEdge = catcherView.frame.origin.x + catcherView.frame.width
                    let catcherViewTopEdge = catcherView.frame.origin.y
//                    let catcherViewBottomEdge = catcherView.frame.origin.y + catcherView.frame.height

                    if fallingMan[n].layer.presentationLayer() == nil {
                        continue
                    }
                    let fallingManLeftEdge = fallingMan[n].layer.presentationLayer()!.frame.origin.x
                    let fallingManRightEdge = fallingMan[n].layer.presentationLayer()!.frame.origin.x + fallingMan[n].layer.presentationLayer()!.frame.width
                    let fallingManTopEdge = fallingMan[n].layer.presentationLayer()!.frame.origin.y
                    let fallingManBottomEdge = fallingMan[n].layer.presentationLayer()!.frame.origin.y + fallingMan[n].layer.presentationLayer()!.frame.height
                    
                    if (catcherViewTopEdge <= fallingManBottomEdge && catcherViewTopEdge > fallingManTopEdge) && ((fallingManRightEdge > catcherViewLeftEdge && fallingManRightEdge < catcherViewRightEdge) || (fallingManLeftEdge < catcherViewRightEdge && fallingManLeftEdge > catcherViewLeftEdge)) {
                        fallingMan[n].alpha = 0
                        fallingMan[n].center.y = 0
                        score += 1
                        scoreLabel.text = String(score)
                    }
                    
                    if catcherViewTopEdge < fallingManTopEdge {
                        fallingMan[n].alpha = 0
                        fallingMan[n].center.y = 0
                        score -= 1
                        if score < 0 { score = 0 }
                        scoreLabel.text = String(score)
                        self.minusOneLabel.alpha = 1
                        self.minusOneLabel.frame.origin.x = fallingMan[n].frame.origin.x
                        UIView.animateWithDuration(0.3, animations: {
                            self.minusOneLabel.transform = CGAffineTransformMakeScale(4, 4)
                            self.minusOneLabel.alpha = 0
                            }, completion: { (Bool) in
                                self.minusOneLabel.transform = CGAffineTransformMakeScale(1, 1)
                        })
                        
                        
                    }
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
    
    @IBAction func tappedChangedNameButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let leaderboardViewController = segue.destinationViewController as! LeaderboardViewController
        
        leaderboardViewController.score1 = score
        leaderboardViewController.playerName = playerLabel.text
    }
    
    func fallingMen() {
        fallingManView = UIImageView(frame: CGRectMake(cloudView.layer.presentationLayer()!.frame.origin.x, cloudView.layer.presentationLayer()!.frame.origin.y + 36, 36, 36))
        fallingManView.contentMode = UIViewContentMode.ScaleAspectFill
        
        fallingManView.image = menImages[Int(arc4random_uniform(UInt32(self.menImages.count)))]
        
        fallingManView.alpha = 1
        fallingMan.append(fallingManView)
        self.view.insertSubview(fallingManView, belowSubview: catcherView)
        
        UIView.animateWithDuration(timeToFall) {
            self.fallingManView.frame.origin.y = 568
        }
        
        
    }
    
    func playBackgroundMusic() {
        do {
            if let bundle = NSBundle.mainBundle().pathForResource("rainingMenMain", ofType: "mp3") {
                let alertSound = NSURL(fileURLWithPath: bundle)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: alertSound)
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                //backgroundMusicPlayer.play()
                
            }
        } catch {
            print(error)
        }
    }
    

}
