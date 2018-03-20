//
//  LogTableViewController.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 15/03/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit
import os.log

class DiveLogTableViewController: UITableViewController {

    //MARK: Properties
    
    var dives = [DiveLog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved dives, otherwise load sample data.
        if let savedDives = loadDives() {
            dives += savedDives
        }
        else {
            // Load the sample data.
            loadSampleDives()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DiveLogTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DiveLogTableViewCell  else {
            fatalError("The dequeued cell is not an instance of DiveLogTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        
        let dive = dives[indexPath.row]
        
        cell.noLabel.text = dive.no
        cell.dateLabel.text = dive.date
        cell.timeLabel.text = dive.time
        cell.maxDepthLabel.text = dive.maxDepth
        cell.durationLabel.text = dive.duration
        cell.locationLabel.text = dive.location
        cell.divingSpotLabel.text = dive.divingSpot
        
        cell.photoImageView.image = dive.photo
        
        
//        cell.nameLabel.text = meal.name
//        cell.photoImageView.image = meal.photo
//        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
     }
    
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dives.remove(at: indexPath.row)
            saveDives()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
     }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new diveLog.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            
            //var diveDetailViewController: UIViewController?

            if(segue.destination is DiveLogViewController) {
                
                guard let diveDetailViewController = segue.destination as? DiveLogViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedDiveLogCell = sender as? DiveLogTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedDiveLogCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedDiveLog = dives[indexPath.row]
                diveDetailViewController.dive = selectedDiveLog
                
            } else if(segue.destination is FirstViewController) {
            
                guard let diveDetailViewController = segue.destination as? FirstViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedDiveLogCell = sender as? DiveLogTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedDiveLogCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedDiveLog = dives[indexPath.row]
                diveDetailViewController.dive = selectedDiveLog
                
            } else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            /*
            guard let diveDetailViewController = segue.destination as? DiveLogViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
 
            guard let diveDetailFirstViewController = segue.destination as? FirstViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            */
            /*
            guard let selectedDiveLogCell = sender as? DiveLogTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedDiveLogCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedDiveLog = dives[indexPath.row]
            diveDetailViewController.dive = selectedDiveLog
             */
            // diveDetailFirstViewController.dive = selectedDiveLog
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToDiveLogList(sender: UIStoryboardSegue) {
        /*
        if let sourceViewController = sender.source as? DiveLogViewController, let dive = sourceViewController.dive {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: dives.count, section: 0)
            
            dives.append(dive)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        } 
         */

        if let sourceViewController = sender.source as? DiveLogViewController, let dive = sourceViewController.dive {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing dive.
                dives[selectedIndexPath.row] = dive
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new dive.
                let newIndexPath = IndexPath(row: dives.count, section: 0)
                
                dives.append(dive)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the dives.
            saveDives()
        }
        
    }
    
    //MARK: Private Methods
    
    private func loadSampleDives() {
        
        let photo1 = UIImage(named: "samplePhoto1")
        let photo2 = UIImage(named: "samplePhoto2")
        let photo3 = UIImage(named: "samplePhoto3")
        let photo4 = UIImage(named: "samplePhoto4")
        let photo5 = UIImage(named: "samplePhoto5")
        let photo6 = UIImage(named: "samplePhoto6")
        let photo7 = UIImage(named: "samplePhoto7")
        let photo8 = UIImage(named: "samplePhoto8")
        let photo9 = UIImage(named: "samplePhoto9")
         
        guard let dive1 = DiveLog(no: "1", date: "06/07/2010", time: "10:00", maxDepth: "16.5m", duration: "31min", location: "Antalya, Türkiye", divingSpot: "Pırasalı Adası, Adrasan", photo: photo1, timeOUT: "10:31", barStart: "200", barEnd: "50", buddy: "Ertan Şide", entrance: "Boat", repetitive: "No", purpose: "Training", environment: "Calm", temperatures: "24 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive1")
        }
        
        guard let dive2 = DiveLog(no: "2", date: "07/07/2010", time: "14:00", maxDepth: "20m", duration: "40min", location: "Antalya, Türkiye", divingSpot: "Lodos Limanı, Adrasan", photo: photo2, timeOUT: "14:40", barStart: "100", barEnd: "40", buddy: "Ertan Şide", entrance: "Shore", repetitive: "No", purpose: "Recreational", environment: "Some Current", temperatures: "22 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive2")
        }
        
        guard let dive3 = DiveLog(no: "3", date: "09/08/2010", time: "11:00", maxDepth: "28m", duration: "25min", location: "Antalya, Türkiye", divingSpot: "St. Didier Batığı", photo: photo3, timeOUT: "11:25", barStart: "120", barEnd: "60", buddy: "Ertan Şide", entrance: "Boat", repetitive: "No", purpose: "Recreational", environment: "Calm", temperatures: "16 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive3")
        }
        
        guard let dive4 = DiveLog(no: "4", date: "06/07/2011", time: "10:00", maxDepth: "16.5m", duration: "31min", location: "Antalya, Türkiye", divingSpot: "BatCave, Adrasan", photo: photo4, timeOUT: "10:31", barStart: "200", barEnd: "50", buddy: "Jose Perez", entrance: "Boat", repetitive: "No", purpose: "Training", environment: "Calm", temperatures: "24 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive4")
        }
        
        guard let dive5 = DiveLog(no: "5", date: "17/08/2011", time: "14:00", maxDepth: "20m", duration: "40min", location: "İzmir, Türkiye", divingSpot: "Karaburun, İzmir Burnu", photo: photo5, timeOUT: "14:40", barStart: "100", barEnd: "40", buddy: "Ertan Şide", entrance: "Shore", repetitive: "No", purpose: "Recreational", environment: "Mixed", temperatures: "22 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive5")
        }
        
        guard let dive6 = DiveLog(no: "6", date: "09/08/2012", time: "11:00", maxDepth: "28m", duration: "25min", location: "Muğla, Türkiye", divingSpot: "Pınar Batığı, Bodrum", photo: photo6, timeOUT: "11:25", barStart: "120", barEnd: "60", buddy: "Sercan Kulaksızoğulları", entrance: "Shore", repetitive: "No", purpose: "Recreational", environment: "Calm", temperatures: "16 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive6")
        }
        
        guard let dive7 = DiveLog(no: "7", date: "06/07/2013", time: "10:00", maxDepth: "16.5m", duration: "31min", location: "Antalya, Türkiye", divingSpot: "Pırasalı Adası, Adrasan", photo: photo7, timeOUT: "10:31", barStart: "200", barEnd: "50", buddy: "Ertan Şide", entrance: "Boat", repetitive: "No", purpose: "Training", environment: "Calm", temperatures: "24 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive7")
        }
        
        guard let dive8 = DiveLog(no: "8", date: "17/08/2014", time: "14:00", maxDepth: "20m", duration: "40min", location: "İzmir, Türkiye", divingSpot: "Karaburun, İzmir Burnu", photo: photo8, timeOUT: "14:40", barStart: "100", barEnd: "40", buddy: "Kamil Özbur", entrance: "Shore", repetitive: "No", purpose: "Recreational", environment: "Mixed", temperatures: "22 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive8")
        }
        
        guard let dive9 = DiveLog(no: "9", date: "09/08/2015", time: "11:00", maxDepth: "28m", duration: "25min", location: "Muğla, Türkiye", divingSpot: "Pınar Batığı, Bodrum", photo: photo9, timeOUT: "11:25", barStart: "120", barEnd: "60", buddy: "Ertan Şide", entrance: "Shore", repetitive: "No", purpose: "Recreational", environment: "Calm", temperatures: "16 C", comments: "comments", verifier: "1234567890") else {
            fatalError("Unable to instantiate dive9")
        }
        /*
        guard let dive3 = DiveLog(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
         */
        
        dives += [dive1, dive2, dive3, dive4, dive5, dive6, dive7, dive8, dive9]
        
    }
    
    private func saveDives() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dives, toFile: DiveLog.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Dives successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save dives...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadDives() -> [DiveLog]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: DiveLog.ArchiveURL.path) as? [DiveLog]
    }
    
}
