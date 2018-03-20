//
//  DiveLogViewController.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 15/03/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit
import os.log

class DiveLogViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var noTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeINTextField: UITextField!
    @IBOutlet weak var maxDepthTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var divingSpotTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var timeOUTTextField: UITextField!
    @IBOutlet weak var barStartTextField: UITextField!
    @IBOutlet weak var barEndTextField: UITextField!
    
    @IBOutlet weak var buddyTextField: UITextField!
    @IBOutlet weak var entranceTextField: UITextField!
    @IBOutlet weak var repetitiveTextField: UITextField!
    @IBOutlet weak var purposeTextField: UITextField!
    @IBOutlet weak var environmentTextField: UITextField!
    @IBOutlet weak var temperaturesTextField: UITextField!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var verifierTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `DiveLogTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new diveLog.
     */
    var dive: DiveLog?
    var datePicker : UIDatePicker!
    var timeINPicker : UIDatePicker!
    var timeOUTPicker : UIDatePicker!
    
    let picker = UIPickerView()
    var depth = Array(1...42).map { _ in "" }

    //var selectedTextField : UITextField!
    //let datePicker = UIDatePicker(); // datePicker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        noTextField.delegate = self
        dateTextField.delegate = self
        timeINTextField.delegate = self
        timeOUTTextField.delegate = self
        //maxDepthTextField.delegate = self
        
        // binding textField to picker
        //maxDepthTextField.inputView = picker
        
        
        // Set up views if editing an existing Meal.
        if let dive = dive {
            navigationItem.title = dive.location
            noTextField.text = dive.no
            dateTextField.text = dive.date
            timeINTextField.text = dive.time
            maxDepthTextField.text = dive.maxDepth
            durationTextField.text = dive.duration
            locationTextField.text = dive.location
            divingSpotTextField.text = dive.divingSpot
            photoImageView.image = dive.photo
            
            timeOUTTextField.text = dive.timeOUT
            barStartTextField.text = dive.barStart
            barEndTextField.text = dive.barEnd
            
            buddyTextField.text = dive.buddy
            entranceTextField.text = dive.entrance
            repetitiveTextField.text = dive.repetitive
            purposeTextField.text = dive.purpose
            environmentTextField.text = dive.environment
            temperaturesTextField.text = dive.temperatures
            commentsTextView.text = dive.comments
            verifierTextField.text = dive.verifier
        } 
        
        
        // Enable the Save button only if the text field has a valid Meal name.
        // updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUpDate(self.dateTextField)
        self.pickUpTimeIN(self.timeINTextField)
        self.pickUpTimeOUT(self.timeOUTTextField)
        // Disable the Save button while editing.
        //saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: UIDatePicker
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        self.datePicker.locale = NSLocale.current
        self.datePicker.maximumDate = Date() // This will avoid you from setting a future date.
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        // toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(datePickerDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(datePickerCancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    func datePickerDoneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .short       //.medium
        dateFormatter1.timeStyle = .none
        dateTextField.text = dateFormatter1.string(from: datePicker.date)
        dateTextField.resignFirstResponder()
    }
    
    func datePickerCancelClick() {
        dateTextField.resignFirstResponder()
    }
    
    /*
    func createDatePicker(_ textField: UITextField) {
        // format for picker
        datePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bat button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        dateTextField.inputView  = datePicker
    }
    
    func donePressed() {
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        dateTextField.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
    */

    // TimeIN Picker
    func pickUpTimeIN(_ textField : UITextField){
        // DatePicker
        self.timeINPicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.timeINPicker.backgroundColor = UIColor.white
        self.timeINPicker.datePickerMode = UIDatePickerMode.time
        self.timeINPicker.locale = NSLocale.current
        textField.inputView = self.timeINPicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        // toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(timePickerINDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(timePickerINCancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    func timePickerINDoneClick() {
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .none       //.medium
        dateFormatter2.timeStyle = .short
        timeINTextField.text = dateFormatter2.string(from: timeINPicker.date)
        timeINTextField.resignFirstResponder()
    }
    func timePickerINCancelClick() {
        timeINTextField.resignFirstResponder()
    }
    
    // TimeOUT Picker
    func pickUpTimeOUT(_ textField : UITextField){
        // DatePicker
        self.timeOUTPicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.timeOUTPicker.backgroundColor = UIColor.white
        self.timeOUTPicker.datePickerMode = UIDatePickerMode.time
        self.timeOUTPicker.locale = NSLocale.current
        textField.inputView = self.timeOUTPicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        // toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(timePickerOUTDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(timePickerOUTCancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    func timePickerOUTDoneClick() {
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateStyle = .none       //.medium
        dateFormatter3.timeStyle = .short
        timeOUTTextField.text = dateFormatter3.string(from: timeOUTPicker.date)
        timeOUTTextField.resignFirstResponder()
    }
    func timePickerOUTCancelClick() {
        timeOUTTextField.resignFirstResponder()
    }
    
    // ..........................................NOT Connected YET..............................................................
    // MARK: UIPickerView
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return depth.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return depth[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        maxDepthTextField.text = depth[row]
        self.view.endEditing(false)
    }
    // ..........................................................................................................................
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddDiveLogMode = presentingViewController is UINavigationController
        
        if isPresentingInAddDiveLogMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The DiveLogViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let no = noTextField.text ?? ""
        let date = dateTextField.text ?? ""
        let timeIN = timeINTextField.text ?? ""
        let maxDepth = maxDepthTextField.text ?? ""
        let duration = durationTextField.text ?? ""
        let location = locationTextField.text ?? ""
        let divingSpot = divingSpotTextField.text ?? ""
        let photo = photoImageView.image
        
        let timeOUT = timeOUTTextField.text ?? ""
        let barStart = barStartTextField.text ?? ""
        let barEnd = barEndTextField.text ?? ""
        
        let buddy = buddyTextField.text ?? ""
        let entrance = entranceTextField.text ?? ""
        let repetitive = repetitiveTextField.text ?? ""
        let purpose = purposeTextField.text ?? ""
        let environment = environmentTextField.text ?? ""
        let temperatures = temperaturesTextField.text ?? ""
        let comments = commentsTextView.text ?? ""
        let verifier = verifierTextField.text ?? ""
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        dive = DiveLog(no: no, date: date, time: timeIN, maxDepth: maxDepth, duration: duration, location: location, divingSpot: divingSpot, photo: photo, timeOUT: timeOUT, barStart: barStart, barEnd: barEnd, buddy: buddy, entrance: entrance, repetitive: repetitive, purpose: purpose, environment: environment, temperatures: temperatures, comments: comments, verifier: verifier)
    }
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        noTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Methods

    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = verifierTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}
