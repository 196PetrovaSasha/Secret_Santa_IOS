
import Foundation


// Define a LoginController class
public class LoginController {
  // Method to login a user
  public static func loginUser(name:String, password:String) -> Bool {
      // Use the checkUser method of the UserManager class to verify the user's credentials
      // Returns true if the user exists and the password matches, false otherwise
      return UserManager.shared.checkUser(name: name, password: password)
  }
}
