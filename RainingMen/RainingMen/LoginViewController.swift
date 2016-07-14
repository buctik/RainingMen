//
//  LoginViewController.swift
//  RainingMen
//
//  Created by Karan Khurana on 6/27/16.
//  Copyright © 2016 Karan Khurana. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var bigCloudView: UIImageView!
    @IBOutlet weak var smallCloudView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var backgroundMusicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bigCloudView.center.x = 450
        self.smallCloudView.center.x = -100
        self.titleLabel.alpha = 0
        self.startButton.alpha = 0
        self.nameField.alpha = 0
        self.nameLabel.alpha = 0
        
        playBackgroundMusic()
        backgroundMusicPlayer.play()
        
        UIView.animateWithDuration(0.5) {
            self.bigCloudView.center.x = 227
            self.smallCloudView.center.x = 136
            self.titleLabel.alpha = 1
            self.startButton.alpha = 1
            self.nameField.alpha = 1
            self.nameLabel.alpha = 1
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationViewController = segue.destinationViewController as! GameViewController
        

        if self.nameField.text == "" {
            destinationViewController.player = "Player 1"
        }
        else {
            destinationViewController.player = self.nameField.text
        }
        backgroundMusicPlayer.stop()
        
        
    }
    
    
    func playBackgroundMusic() {
        do {
            if let bundle = NSBundle.mainBundle().pathForResource("rainingMenIntro", ofType: "mp3") {
                let alertSound = NSURL(fileURLWithPath: bundle)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                print("before play")
                try AVAudioSession.sharedInstance().setActive(true)
                try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: alertSound)
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
                print("after play")
            }
        } catch {
            print(error)
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
