//
//  EditDiverProfileViewController.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 05/04/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit
import os.log

class EditDiverProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    //MARK: Properties
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var nationalityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var certificationProgrammeTextField: UITextField!
    @IBOutlet weak var diverNoTextField: UITextField!
    @IBOutlet weak var issuerTextField: UITextField!
    @IBOutlet weak var dateOfIssueTextField: UITextField!
    @IBOutlet weak var instructorTextField: UITextField!
    @IBOutlet weak var instructorNoTextField: UITextField!
    
    @IBOutlet weak var emergencyContactNameTextField: UITextField!
    @IBOutlet weak var emergencyContactRelationTextField:UITextField!
    @IBOutlet weak var emergencyContactPhoneTextField: UITextField!
    @IBOutlet weak var emergencyContactEmailTextField: UITextField!
    
    @IBOutlet weak var allergiesTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is  passed by `SecondViewController` in `prepare(for:sender:)`.
     */
    var profile: DiverProfile?
    var datePicker : UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        firstNameTextField.delegate = self
        dateOfBirthTextField.delegate = self

//        firstNameTextField.text = profile?.firstName
//        lastNameTextField.text = profile?.lastName
//        dateOfBirthTextField.text = profile?.dateOfBirth
//        nationalityTextField.text = profile?.nationality
//        phoneTextField.text = profile?.phone
//        emailTextField.text = profile?.email
//        profilePhotoImageView.image = profile?.profilePhoto
        
        // Do any additional setup after loading the view.
    }

    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUpDate(self.dateOfBirthTextField)
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: UIDatePicker
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        self.datePicker.locale = NSLocale.current
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        // toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .short       //.medium
        dateFormatter1.timeStyle = .none
        dateOfBirthTextField.text = dateFormatter1.string(from: datePicker.date)
        dateOfBirthTextField.resignFirstResponder()
    }
    
    func cancelClick() {
        dateOfBirthTextField.resignFirstResponder()
    }
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let dateOfBirth = dateOfBirthTextField.text ?? ""
        let nationality = nationalityTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let profilePhoto = profilePhotoImageView.image
        
        let certificationProgramme = certificationProgrammeTextField.text ?? ""
        let diverNo = diverNoTextField.text ?? ""
        let issuer = issuerTextField.text ?? ""
        let dateOfIssue = dateOfIssueTextField.text ?? ""
        let instructor = instructorTextField.text ?? ""
        let instructorNo = instructorNoTextField.text ?? ""
        
        let emergencyContactName = emergencyContactNameTextField.text ?? ""
        let emergencyContactRelation = emergencyContactRelationTextField.text ?? ""
        let emergencyContactPhone = emergencyContactPhoneTextField.text ?? ""
        let emergencyContactEmail = emergencyContactEmailTextField.text ?? ""
        
        let allergies = allergiesTextField.text ?? ""
        let bloodType = bloodTypeTextField.text ?? ""
        let height = heightTextField.text ?? ""
        let weight = weightTextField.text ?? ""
        
        // Set the meal to be passed to SecondViewController after the unwind segue.
        profile = DiverProfile(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, nationality: nationality, phone: phone, email: email, profilePhoto: profilePhoto, certificationProgramme: certificationProgramme, diverNo: diverNo, issuer: issuer, dateOfIssue: dateOfIssue, instructor: instructor, instructorNo: instructorNo, emergencyContactName: emergencyContactName, emergencyContactRelation: emergencyContactRelation, emergencyContactPhone: emergencyContactPhone, emergencyContactEmail: emergencyContactEmail, allergies: allergies, bloodType: bloodType, height: height, weight: weight)
    }

}
