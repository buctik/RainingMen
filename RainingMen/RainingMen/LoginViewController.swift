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

    @IBOutlet weak var nameField: UITextField!
    
    var backgroundMusicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundMusic()

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
