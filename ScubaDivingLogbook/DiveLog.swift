//
//  DiveLog.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 15/03/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit
import os.log

class DiveLog: NSObject, NSCoding {
    
    //MARK: Properties
    
    var no: String
    var date: String
    var time: String
    var maxDepth: String
    var duration: String
    var location: String
    var divingSpot: String
    
    var photo: UIImage?
    
    var timeOUT: String
    var barStart: String
    var barEnd: String
    
    var buddy: String
    var entrance: String
    var repetitive: String
    var purpose: String
    var environment: String
    var temperatures: String
    var comments: String
    var verifier: String
    
//    var rating: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("dives")
    
    //MARK: Types
    
    struct PropertyKey {
        static let no = "no"
        static let date = "date"
        static let time = "time"
        static let maxDepth = "maxDepth"
        static let duration = "duration"
        static let location = "location"
        static let divingSpot  = "divingSpot"
        
        static let photo = "photo"
        
        static let  timeOUT = "timeOUT"
        static let  barStart  = "barStart"
        static let  barEnd = "barEnd"
        static let  buddy = "buddy"
        static let  entrance = "entrance"
        static let  repetitive = "repetitive"
        static let  purpose = "purpose"
        static let  environment = "environment"
        static let  temperatures = "temperatures"
        static let  comments = "comments"
        static let  verifier = "verifier"
        
//        static let rating = "rating"
        // TODO:
    }
    
    
    //MARK: Initialization
    
    init?(no: String, date: String, time: String, maxDepth: String, duration: String, location: String, divingSpot: String, photo: UIImage?, timeOUT: String, barStart: String, barEnd: String, buddy: String, entrance: String, repetitive: String, purpose: String, environment: String, temperatures: String, comments: String, verifier: String) {
        
        // The name must not be empty
        guard !no.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !date.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !time.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !maxDepth.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !duration.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !location.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !divingSpot.isEmpty else {
            return nil
        }
        //------------------------------------------------------
        // The name must not be empty
        guard !timeOUT.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !barStart.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !barEnd.isEmpty else {
            return nil
        }
        //------------------------------------------------------
        // The name must not be empty
        guard !buddy.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !entrance.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !repetitive.isEmpty else {
            return nil
        }        // The name must not be empty
        guard !purpose.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !environment.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !temperatures.isEmpty else {
            return nil
        }
        // The name must not be empty
        guard !comments.isEmpty else {
            return nil
        }        // The name must not be empty
        guard !verifier.isEmpty else {
            return nil
        }

        // The name must not be empty
//        guard !name.isEmpty else {
//            return nil
//        }
        
        // The rating must be between 0 and 5 inclusively
//        guard (rating >= 0) && (rating <= 5) else {
//            return nil
//        }
//        
        // Initialize stored properties.
        
        self.no = no
        self.date = date
        self.time = time
        self.maxDepth = maxDepth
        self.duration = duration
        self.location = location
        self.divingSpot  = divingSpot
        
        self.photo = photo
        
        self.timeOUT = timeOUT
        self.barStart  = barStart
        self.barEnd = barEnd
        
        self.buddy = buddy
        self.entrance = entrance
        self.repetitive = repetitive
        self.purpose = purpose
        self.environment = environment
        self.temperatures = temperatures
        self.comments = comments
        self.verifier = verifier
        
//        self.rating = rating
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(no, forKey: PropertyKey.no)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(maxDepth, forKey: PropertyKey.maxDepth)
        aCoder.encode(duration, forKey: PropertyKey.duration)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(divingSpot, forKey: PropertyKey.divingSpot)
        
        aCoder.encode(timeOUT, forKey: PropertyKey.timeOUT)
        aCoder.encode(barStart, forKey: PropertyKey.barStart)
        aCoder.encode(barEnd, forKey: PropertyKey.barEnd)
        
        aCoder.encode(buddy, forKey: PropertyKey.buddy)
        aCoder.encode(entrance, forKey: PropertyKey.entrance)
        aCoder.encode(repetitive, forKey: PropertyKey.repetitive)
        aCoder.encode(purpose, forKey: PropertyKey.purpose)
        aCoder.encode(environment, forKey: PropertyKey.environment)
        aCoder.encode(temperatures, forKey: PropertyKey.temperatures)
        aCoder.encode(comments, forKey: PropertyKey.comments)
        aCoder.encode(verifier, forKey: PropertyKey.verifier)
        
//        aCoder.encode(rating, forKey: PropertyKey.rating)
        
//        aCoder.encode(name, forKey: PropertyKey.name)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let no = aDecoder.decodeObject(forKey: PropertyKey.no) as? String else {
            os_log("Unable to decode the no for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the date for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let time = aDecoder.decodeObject(forKey: PropertyKey.time) as? String else {
            os_log("Unable to decode the time for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let maxDepth = aDecoder.decodeObject(forKey: PropertyKey.maxDepth) as? String else {
            os_log("Unable to decode the maxDepth for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let duration = aDecoder.decodeObject(forKey: PropertyKey.duration) as? String else {
            os_log("Unable to decode the duration for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String else {
            os_log("Unable to decode the location for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let divingSpot = aDecoder.decodeObject(forKey: PropertyKey.divingSpot) as? String else {
            os_log("Unable to decode the divingSpot for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        //------------------------------------------------------------------------------------------------------------
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let timeOUT = aDecoder.decodeObject(forKey: PropertyKey.timeOUT) as? String else {
            os_log("Unable to decode the timeOUT for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let barStart = aDecoder.decodeObject(forKey: PropertyKey.barStart) as? String else {
            os_log("Unable to decode the barStart for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let barEnd = aDecoder.decodeObject(forKey: PropertyKey.barEnd) as? String else {
            os_log("Unable to decode the barEnd for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        //------------------------------------------------------------------------------------------------------------
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let buddy = aDecoder.decodeObject(forKey: PropertyKey.buddy) as? String else {
            os_log("Unable to decode the buddy for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let entrance = aDecoder.decodeObject(forKey: PropertyKey.entrance) as? String else {
            os_log("Unable to decode the entrance for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let repetitive = aDecoder.decodeObject(forKey: PropertyKey.repetitive) as? String else {
            os_log("Unable to decode the repetitive for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let purpose = aDecoder.decodeObject(forKey: PropertyKey.purpose) as? String else {
            os_log("Unable to decode the purpose for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let environment = aDecoder.decodeObject(forKey: PropertyKey.environment) as? String else {
            os_log("Unable to decode the environment for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let temperatures = aDecoder.decodeObject(forKey: PropertyKey.temperatures) as? String else {
            os_log("Unable to decode the temperatures for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let comments = aDecoder.decodeObject(forKey: PropertyKey.comments) as? String else {
            os_log("Unable to decode the comments for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let verifier = aDecoder.decodeObject(forKey: PropertyKey.verifier) as? String else {
            os_log("Unable to decode the verifier for a DiveLog object.", log: OSLog.default, type: .debug)
            return nil
        }
        
//        // The name is required. If we cannot decode a name string, the initializer should fail.
//        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
//            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
//            return nil
//        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
//        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(no: no, date: date, time: time, maxDepth: maxDepth, duration: duration, location: location, divingSpot: divingSpot, photo: photo, timeOUT: timeOUT, barStart: barStart, barEnd: barEnd, buddy: buddy, entrance: entrance, repetitive: repetitive, purpose: purpose, environment: environment, temperatures: temperatures, comments: comments, verifier: verifier)
        
    }
    
    
}
