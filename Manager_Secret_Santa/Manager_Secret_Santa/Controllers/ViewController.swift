
import UIKit
import SwiftUI

// Define a ViewController class that inherits from UIViewController
class ViewController: UIViewController {

   // Override the viewDidLoad method
   override func viewDidLoad() {
       super.viewDidLoad()
       // Call the displayLoginView method when the view loads
       displayLoginView()
   }
   
   // Method to display the login view
   public func displayLoginView() {
       // Create a UIHostingController with the LoginView as its root view
       let loginView = UIHostingController(rootView: LoginView())
       // Add the UIHostingController as a child of the current view controller
       addChild(loginView)
       // Add the UIHostingController's view to the current view controller's view hierarchy
       view.addSubview(loginView.view)
       // Notify the UIHostingController that it has been moved to the current view controller
       loginView.didMove(toParent: self)
   }
}
