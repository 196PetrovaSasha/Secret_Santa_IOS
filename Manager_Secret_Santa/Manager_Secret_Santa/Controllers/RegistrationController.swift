
import Foundation

// Define a RegistrationController class
public class RegistrationController {
   // Method to register a new user
   public static func regUser(name:String, password:String) -> Bool {
       // First, check if a user with the given name and password already exists
       if UserManager.shared.checkUser(name: name, password: password) {
           // If such a user exists, return false to indicate that the registration failed
           return false
       } else {
           // If no such user exists, create a new user with the given name and password
           UserManager.shared.createUser(name: name, password: password)
           // Return true to indicate that the registration was successful
           return true
       }
   }
}

