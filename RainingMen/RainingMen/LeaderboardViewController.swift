//
//  LeaderboardViewController.swift
//  RainingMen
//
//  Created by Omar Siddiqui on 6/21/16.
//  Copyright © 2016 Karan Khurana. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var leader1Label: UILabel!
    @IBOutlet weak var leader2Label: UILabel!
    @IBOutlet weak var leader3Label: UILabel!
    @IBOutlet weak var leader4Label: UILabel!
    @IBOutlet weak var leader5Label: UILabel!
    
    @IBOutlet weak var score1Label: UILabel!
    @IBOutlet weak var score2Label: UILabel!
    @IBOutlet weak var score3Label: UILabel!
    @IBOutlet weak var score4Label: UILabel!
    @IBOutlet weak var score5Label: UILabel!
    
    
    var score1: Int = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score1Label.text = String(score1)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedBackButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func updateLeaderBoard () {
        
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
