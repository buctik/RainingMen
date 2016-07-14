//
//  LeaderboardViewController.swift
//  RainingMen
//
//  Created by Omar Siddiqui on 6/21/16.
//  Copyright © 2016 Karan Khurana. All rights reserved.
//

import UIKit
import Firebase

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
    
    var leaderArray = [UILabel]()
    var scoreArray = [UILabel]()
    
    
    var score1: Int!
    var score2: Int!
    var score3: Int!
    var score4: Int!
    var score5: Int!
    
    var items = [NSDictionary]()
    
    var playerName: String!
    
    var ref = FIRDatabase.database().referenceFromURL("https://rainingmen-881fc.firebaseio.com")
    
    override func viewWillAppear(animated: Bool) {
        
        leaderArray.append(leader1Label)
        leaderArray.append(leader2Label)
        leaderArray.append(leader3Label)
        leaderArray.append(leader4Label)
        leaderArray.append(leader5Label)
        
        scoreArray.append(score1Label)
        scoreArray.append(score2Label)
        scoreArray.append(score3Label)
        scoreArray.append(score4Label)
        scoreArray.append(score5Label)
        
        let orderValueRef = ref.queryOrderedByValue().queryLimitedToLast(5)
        orderValueRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            var i = 4
            //code
            for n in snapshot.children {
                
                let snap = n as! FIRDataSnapshot
                self.items.append([snap.key:snap.value!])
                
            }
            
//            print("\(self.items)")
            
            
            for item in self.items.prefix(5) {
                
                print("\(item)")
                for (key, value) in item {
                    self.leaderArray[i].text = key as? String
                    self.scoreArray[i].text = String(value as! Int)
                }
                i = i - 1
                
                
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("\(score1)")
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(score1, forKey: playerName)
        //if let defaults.integerForKey(playerName)
        

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
