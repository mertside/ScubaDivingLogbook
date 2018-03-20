//
//  FirstViewController.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 14/03/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit
import os.log

class FirstViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var maxDepthLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var divingSpotLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var timeOUTLabel: UILabel!
    @IBOutlet weak var barStartLabel: UILabel!
    @IBOutlet weak var barEndLabel: UILabel!
    
    @IBOutlet weak var buddyLabel: UILabel!
    @IBOutlet weak var entranceLabel: UILabel!
    @IBOutlet weak var repetitiveLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var environmentLabel: UILabel!
    @IBOutlet weak var temperaturesLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var verifierLabel: UILabel!
    
    /*
     This value is either passed by `DiveLogTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new diveLog.
     */
    var dive: DiveLog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        noLabel.text = dive?.no
        dateLabel.text = dive?.date
        timeLabel.text = dive?.time
        maxDepthLabel.text = dive?.maxDepth
        durationLabel.text = dive?.duration
        locationLabel.text = dive?.location
        divingSpotLabel.text = dive?.divingSpot
        
        photoImageView.image = dive?.photo
        
        timeOUTLabel.text = dive?.timeOUT
        barStartLabel.text = dive?.barStart
        barEndLabel.text = dive?.barEnd
        
        buddyLabel.text = dive?.buddy
        entranceLabel.text = dive?.entrance
        repetitiveLabel.text = dive?.repetitive
        purposeLabel.text = dive?.purpose
        environmentLabel.text = dive?.environment
        temperaturesLabel.text = dive?.temperatures
        commentsTextView.text = dive?.comments
        verifierLabel.text = dive?.verifier
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "EditItem":
            os_log("Editting a  diveLog.", log: OSLog.default, type: .debug)
            /*
             guard let diveDetailViewController = segue.destination as? DiveLogViewController else {
             fatalError("Unexpected destination: \(segue.destination)")
 
            }
            */
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    

}

