
import Foundation
import UIKit
import CoreData

// Define a singleton UserManager class
public final class UserManager: NSObject {
   // Singleton instance
   public static let shared = UserManager()
   // Private initializer to prevent creating new instances
   private override init(){}

   // Access the AppDelegate instance
   private var appDelegate: AppDelegate{
       UIApplication.shared.delegate as! AppDelegate
   }

   // Access the CoreData context
   private var context: NSManagedObjectContext {
       appDelegate.persistentContainer.viewContext
   }

   // Method to create a new User
   public func createUser(name: String, password: String) {
       // Get the User entity description
       guard let userEntityDescription = NSEntityDescription.entity(forEntityName: "User", in: context) else {
           return
       }
       // Create a new User
       let user = User(entity: userEntityDescription, insertInto: context)
       // Set the name and password of the User
       user.name = name
       user.password = password
       // Save the context
       appDelegate.saveContext()
   }

   // Method to fetch all Users
   public func fetchUsers() -> [User] {
       // Create a fetch request for the User entity
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
       do {
           // Fetch all Users
           return try context.fetch(fetchRequest) as! [User]
       } catch {
           // Print the error
           print(error.localizedDescription)
       }

       return []
   }

   // Method to fetch a User by name
   public func fetchUser(with name: String) -> User? {
      // Create a fetch request for the User entity
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
      do {
          // Fetch all Users
          let users = try? context.fetch(fetchRequest) as? [User]
          // Return the first User whose name matches the given name
          return users?.first(where: {$0.name == name})
      }
   }
   
   // Method to check if a User exists with the given name and password
   public func checkUser(name:String, password:String) -> Bool{
       // Create a fetch request for the User entity
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
       do {
           // Fetch all Users
           let users = try? context.fetch(fetchRequest) as? [User]
           // Return the first User whose name and password match the given name and password
           let user = users?.first(where: {$0.name == name && $0.password == password})
           return user != nil
       }
       return false
   }
}
