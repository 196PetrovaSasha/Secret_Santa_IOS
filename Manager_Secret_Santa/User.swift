
import Foundation
import CoreData

// Define a User class that inherits from NSManagedObject
@objc(User)
public class User: NSManagedObject {}

// Extend the User class with properties
extension User {

   // Declare properties for the name and password of the user
   @NSManaged public var name: String?
   @NSManaged public var password: String?

}


extension User : Identifiable {

}
