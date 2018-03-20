//
//  SecondViewController.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 14/03/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit
import os.log

class SecondViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var certificationProgrammeLabel: UILabel!
    @IBOutlet weak var diverNoLabel: UILabel!
    @IBOutlet weak var issuerLabel: UILabel!
    @IBOutlet weak var dateOfIssueLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var instructorNoLabel: UILabel!
    
    @IBOutlet weak var emergencyContactNameLabel: UILabel!
    @IBOutlet weak var emergencyContactRelationLabel: UILabel!
    @IBOutlet weak var emergencyContactPhoneLabel: UILabel!
    @IBOutlet weak var emergencyContactEmailLabel: UILabel!
    
    @IBOutlet weak var allergiesLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    var diverProfile : DiverProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load any saved diver Profiles, otherwise load sample data.
        if let savedProfile = loadProfile() {
            diverProfile = savedProfile
        } else {
            // Load the sample data.
            loadSampleProfile()
        }
        
        firstNameLabel.text = diverProfile?.firstName
        lastNameLabel.text = diverProfile?.lastName
        dateOfBirthLabel.text = diverProfile?.dateOfBirth
        nationalityLabel.text = diverProfile?.nationality
        phoneLabel.text = diverProfile?.phone
        emailLabel.text = diverProfile?.email
        profilePhotoImageView.image = diverProfile?.profilePhoto
        
        certificationProgrammeLabel.text = diverProfile?.certificationProgramme
        diverNoLabel.text = diverProfile?.diverNo
        issuerLabel.text = diverProfile?.issuer
        dateOfIssueLabel.text = diverProfile?.dateOfIssue
        instructorLabel.text = diverProfile?.instructor
        instructorNoLabel.text = diverProfile?.instructorNo
        
        emergencyContactNameLabel.text = diverProfile?.emergencyContactName
        emergencyContactRelationLabel.text = diverProfile?.emergencyContactRelation
        emergencyContactPhoneLabel.text = diverProfile?.emergencyContactPhone
        emergencyContactEmailLabel.text = diverProfile?.emergencyContactEmail
        
        allergiesLabel.text = diverProfile?.allergies
        bloodTypeLabel.text = diverProfile?.bloodType
        heightLabel.text = diverProfile?.height
        weightLabel.text = diverProfile?.weight
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // BELOW IS JUST ADDED AS AN EXPERIMENT CAN BE DELETED OR MODIFIED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "EditProfile":
            os_log("Editting a diver profile.", log: OSLog.default, type: .debug)
            if let profileDetailViewController = segue.destination as? EditDiverProfileViewController {
                profileDetailViewController.profile = diverProfile;
                
                // below is HIGHLY RISKY, TEST IT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                profileDetailViewController.firstNameTextField.text = profileDetailViewController.profile?.firstName
                profileDetailViewController.lastNameTextField.text = profileDetailViewController.profile?.lastName
                profileDetailViewController.dateOfBirthTextField.text = profileDetailViewController.profile?.dateOfBirth
                profileDetailViewController.nationalityTextField.text = profileDetailViewController.profile?.nationality
                profileDetailViewController.phoneTextField.text = profileDetailViewController.profile?.phone
                profileDetailViewController.emailTextField.text = profileDetailViewController.profile?.email
                profileDetailViewController.profilePhotoImageView.image = profileDetailViewController.profile?.profilePhoto
            }
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToSecondView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EditDiverProfileViewController, let profile = sourceViewController.profile {

            // Update an existing meal.
            diverProfile = profile
            
            // Save the meals.
            saveProfile()
            
            viewDidLoad()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleProfile() {
        
        let profilePhoto1 = UIImage(named: "sampleDiverProfilePicture")
        
        guard let sampleProfile = DiverProfile(firstName: "Mert", lastName: "ŞİDE", dateOfBirth: "20/05/1996", nationality: "Turkey", phone: "+90 123 456 7891", email: "mertside@example.com", profilePhoto: profilePhoto1, certificationProgramme: "PADI", diverNo: "1508UP5972", issuer: "WeekendDivers", dateOfIssue: "11/07/2015", instructor: "Ertan ŞİDE", instructorNo: "MSDT-640826", emergencyContactName: "Recai Kutbay", emergencyContactRelation: "Doctor, Uncle", emergencyContactPhone: "+1 (123) 456 78 95", emergencyContactEmail: "recaikutbay@example.com", allergies: "none", bloodType: "O+", height: "180cm", weight: "72kg" ) else {
            fatalError("Unable to instantiate sampleProfile")
        }
        
        diverProfile = sampleProfile
    }
    
    
    private func saveProfile() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(diverProfile!, toFile: DiverProfile.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Profile successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save profile...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadProfile() -> DiverProfile? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: DiverProfile.ArchiveURL.path) as? DiverProfile
    }

}

