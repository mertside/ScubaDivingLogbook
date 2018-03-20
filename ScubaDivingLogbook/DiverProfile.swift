//
//  DiverProfile.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 05/04/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit
import os.log

class DiverProfile: NSObject, NSCoding {
    
    //MARK: Properties
    
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var nationality: String
    var phone: String
    var email: String
    
    var profilePhoto: UIImage?
    
    var certificationProgramme: String
    var diverNo: String
    var issuer: String
    var dateOfIssue: String
    var instructor: String
    var instructorNo: String
    
    var emergencyContactName: String
    var emergencyContactRelation: String
    var emergencyContactPhone: String
    var emergencyContactEmail: String
    
    var allergies: String
    var bloodType: String
    var height: String
    var weight: String

    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("dives")
    
    //MARK: Types
    
    struct PropertyKey {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let dateOfBirth = "dateOfBirth"
        static let nationality = "nationality"
        static let phone = "phone"
        static let email = "email"
        
        static let profilePhoto = "profilePhoto"
        
        static let certificationProgramme = "certificationProgramme"
        static let diverNo = "diverNo"
        static let issuer = "issuer"
        static let dateOfIssue = "dateOfIssue"
        static let instructor = "instructor"
        static let instructorNo = "instructorNo"
        
        static let emergencyContactName = "emergencyContactName"
        static let emergencyContactRelation = "emergencyContactRelation"
        static let emergencyContactPhone = "emergencyContactPhone"
        static let emergencyContactEmail = "emergencyContactEmail"
        
        static let allergies = "allergies"
        static let bloodType = "bloodType"
        static let height = "height"
        static let weight = "weight"
    }
    
    
    //MARK: Initialization
    
    init?(firstName: String, lastName: String, dateOfBirth: String, nationality: String, phone: String, email: String, profilePhoto: UIImage?, certificationProgramme: String, diverNo: String, issuer: String, dateOfIssue: String, instructor: String, instructorNo: String, emergencyContactName: String, emergencyContactRelation: String, emergencyContactPhone: String, emergencyContactEmail: String, allergies: String, bloodType: String, height: String, weight: String) {
        
        // The name must not be empty
        guard !firstName.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !lastName.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !dateOfBirth.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !nationality.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !phone.isEmpty else {
            return nil
        }        // The name must not be empty
        guard !email.isEmpty else {
            return nil
        }
        
        // The certificationProgramme must not be empty .............
        guard !certificationProgramme.isEmpty else {
            return nil
        }
        // The diverNo must not be empty
        guard !diverNo.isEmpty else {
            return nil
        }
        // The issuer must not be empty
        guard !issuer.isEmpty else {
            return nil
        }
        // The dateOfIssue must not be empty
        guard !dateOfIssue.isEmpty else {
            return nil
        }
        // The instructor must not be empty
        guard !instructor.isEmpty else {
            return nil
        }
        // The instructorNo must not be empty
        guard !instructorNo.isEmpty else {
            return nil
        }
        
        // The emergencyContactName must not be empty .................
        guard !emergencyContactName.isEmpty else {
            return nil
        }
        // The emergencyContactRelation must not be empty
        guard !emergencyContactRelation.isEmpty else {
            return nil
        }
        // The emergencyContactPhone must not be empty
        guard !emergencyContactPhone.isEmpty else {
            return nil
        }
        // The emergencyContactEmail must not be empty
        guard !emergencyContactEmail.isEmpty else {
            return nil
        }
        
        // The allergies must not be empty ......................
        guard !allergies.isEmpty else {
            return nil
        }
        // The bloodType must not be empty
        guard !bloodType.isEmpty else {
            return nil
        }
        // The height must not be empty
        guard !height.isEmpty else {
            return nil
        }
        // The weight must not be empty
        guard !weight.isEmpty else {
            return nil
        }

        
        // Initialize stored properties.
        
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.phone = phone
        self.email = email
        
        self.profilePhoto = profilePhoto
        
        self.certificationProgramme = certificationProgramme
        self.diverNo = diverNo
        self.issuer = issuer
        self.dateOfIssue = dateOfIssue
        self.instructor = instructor
        self.instructorNo = instructorNo
        
        self.emergencyContactName = emergencyContactName
        self.emergencyContactRelation = emergencyContactRelation
        self.emergencyContactPhone = emergencyContactPhone
        self.emergencyContactEmail = emergencyContactEmail
        
        self.allergies = allergies
        self.bloodType = bloodType
        self.height = height
        self.weight = weight
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: PropertyKey.firstName)
        aCoder.encode(lastName, forKey: PropertyKey.lastName)
        aCoder.encode(dateOfBirth, forKey: PropertyKey.dateOfBirth)
        aCoder.encode(nationality, forKey: PropertyKey.nationality)
        aCoder.encode(phone, forKey: PropertyKey.phone)
        aCoder.encode(email, forKey: PropertyKey.email)
        
        aCoder.encode(certificationProgramme, forKey: PropertyKey.certificationProgramme)
        aCoder.encode(diverNo, forKey: PropertyKey.diverNo)
        aCoder.encode(issuer, forKey: PropertyKey.issuer)
        aCoder.encode(dateOfIssue, forKey: PropertyKey.dateOfIssue)
        aCoder.encode(instructor, forKey: PropertyKey.instructor)
        aCoder.encode(instructorNo, forKey: PropertyKey.instructorNo)
        
        aCoder.encode(emergencyContactName, forKey: PropertyKey.emergencyContactName)
        aCoder.encode(emergencyContactRelation, forKey: PropertyKey.emergencyContactRelation)
        aCoder.encode(emergencyContactPhone, forKey: PropertyKey.emergencyContactPhone)
        aCoder.encode(emergencyContactEmail, forKey: PropertyKey.emergencyContactEmail)
        
        aCoder.encode(allergies, forKey: PropertyKey.allergies)
        aCoder.encode(bloodType, forKey: PropertyKey.bloodType)
        aCoder.encode(height, forKey: PropertyKey.height)
        aCoder.encode(weight, forKey: PropertyKey.weight)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let firstName = aDecoder.decodeObject(forKey: PropertyKey.firstName) as? String else {
            os_log("Unable to decode the firstName for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let lastName = aDecoder.decodeObject(forKey: PropertyKey.lastName) as? String else {
            os_log("Unable to decode the lastName for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let dateOfBirth = aDecoder.decodeObject(forKey: PropertyKey.dateOfBirth) as? String else {
            os_log("Unable to decode the dateOfBirth for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let nationality = aDecoder.decodeObject(forKey: PropertyKey.nationality) as? String else {
            os_log("Unable to decode the nationality for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let phone = aDecoder.decodeObject(forKey: PropertyKey.phone) as? String else {
            os_log("Unable to decode the phone for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let email = aDecoder.decodeObject(forKey: PropertyKey.email) as? String else {
            os_log("Unable to decode the email for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        //................................................................................................................
        // The certificationProgramme is required. If we cannot decode a name string, the initializer should fail.
        guard let certificationProgramme = aDecoder.decodeObject(forKey: PropertyKey.certificationProgramme) as? String else {
            os_log("Unable to decode the certificationProgramme for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The diverNo is required. If we cannot decode a name string, the initializer should fail.
        guard let diverNo = aDecoder.decodeObject(forKey: PropertyKey.diverNo) as? String else {
            os_log("Unable to decode the diverNo for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The issuer is required. If we cannot decode a name string, the initializer should fail.
        guard let issuer = aDecoder.decodeObject(forKey: PropertyKey.issuer) as? String else {
            os_log("Unable to decode the issuer for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The dateOfIssue is required. If we cannot decode a name string, the initializer should fail.
        guard let dateOfIssue = aDecoder.decodeObject(forKey: PropertyKey.dateOfIssue) as? String else {
            os_log("Unable to decode the dateOfIssue for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The instructor is required. If we cannot decode a name string, the initializer should fail.
        guard let instructor = aDecoder.decodeObject(forKey: PropertyKey.instructor) as? String else {
            os_log("Unable to decode the instructor for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The instructorNo is required. If we cannot decode a name string, the initializer should fail.
        guard let instructorNo = aDecoder.decodeObject(forKey: PropertyKey.instructorNo) as? String else {
            os_log("Unable to decode the instructorNo for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        //................................................................................................................
        // The emergencyContactName is required. If we cannot decode a name string, the initializer should fail.
        guard let emergencyContactName = aDecoder.decodeObject(forKey: PropertyKey.emergencyContactName) as? String else {
            os_log("Unable to decode the emergencyContactName for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The emergencyContactRelation is required. If we cannot decode a name string, the initializer should fail.
        guard let emergencyContactRelation = aDecoder.decodeObject(forKey: PropertyKey.emergencyContactRelation) as? String else {
            os_log("Unable to decode the emergencyContactRelation for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The emergencyContactPhone is required. If we cannot decode a name string, the initializer should fail.
        guard let emergencyContactPhone = aDecoder.decodeObject(forKey: PropertyKey.emergencyContactPhone) as? String else {
            os_log("Unable to decode the emergencyContactPhone for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let emergencyContactEmail = aDecoder.decodeObject(forKey: PropertyKey.emergencyContactEmail) as? String else {
            os_log("Unable to decode the emergencyContactEmail for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        //................................................................................................................
        // The allergies is required. If we cannot decode a name string, the initializer should fail.
        guard let allergies = aDecoder.decodeObject(forKey: PropertyKey.allergies) as? String else {
            os_log("Unable to decode the allergies for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The bloodType is required. If we cannot decode a name string, the initializer should fail.
        guard let bloodType = aDecoder.decodeObject(forKey: PropertyKey.bloodType) as? String else {
            os_log("Unable to decode the bloodType for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The height is required. If we cannot decode a name string, the initializer should fail.
        guard let height = aDecoder.decodeObject(forKey: PropertyKey.height) as? String else {
            os_log("Unable to decode the height for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The weight is required. If we cannot decode a name string, the initializer should fail.
        guard let weight = aDecoder.decodeObject(forKey: PropertyKey.weight) as? String else {
            os_log("Unable to decode the weight for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        //................................................................................................................

        // Because photo is an optional property of Meal, just use conditional cast.
        let profilePhoto = aDecoder.decodeObject(forKey: PropertyKey.profilePhoto) as? UIImage
        
        //        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, nationality: nationality, phone: phone, email: email, profilePhoto: profilePhoto, certificationProgramme: certificationProgramme, diverNo: diverNo, issuer: issuer, dateOfIssue: dateOfIssue, instructor: instructor, instructorNo: instructorNo, emergencyContactName: emergencyContactName, emergencyContactRelation: emergencyContactRelation, emergencyContactPhone: emergencyContactPhone, emergencyContactEmail: emergencyContactEmail, allergies: allergies, bloodType: bloodType, height: height, weight: weight)
        
    }
    
}

