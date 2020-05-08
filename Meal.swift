//
//  Meal.swift
//  FoodTracker
//
//  Created by Xenzaki on 1/5/17.
//
//

import UIKit

class Meal: NSObject, NSCoding {
    
    //MARK: Propertes
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
    static let ArchiveURL = NSURL(fileURLWithPath: DocumentsDirectory).URLByAppendingPathComponent("meals").path!
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        super.init()
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.name)
        aCoder.encodeObject(photo, forKey: PropertyKey.photo)
        aCoder.encodeInteger(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a stirng, the initialzer should fail.
        guard let name = aDecoder.decodeObjectForKey(PropertyKey.name) as? String else {
            print("Unable to decode the name for a Meal object")
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeObjectForKey(PropertyKey.rating) as! Int
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
}
