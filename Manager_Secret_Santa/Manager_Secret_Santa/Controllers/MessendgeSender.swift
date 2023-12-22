
import Foundation

import UIKit
import MessageUI

// Define a MessageSender class that inherits from NSObject
class MessageSender: NSObject {
   
   // Declare a variable to hold a reference to the view controller
   var viewController: UIViewController?
   
   // Method to send a message
   func sendMessage(recipients: [String], body: String) {
       // Check if the device can send text messages
       guard MFMessageComposeViewController.canSendText() else {
           // If not, print an error message and return
           print("Невозможно отправить сообщение")
           return
       }
       
       // Create a MFMessageComposeViewController
       let messageController = MFMessageComposeViewController()
       // Set the recipients and body of the message
       messageController.recipients = recipients
       messageController.body = body
       // Set the delegate of the message compose view controller
       messageController.messageComposeDelegate = self
       
       // Present the message compose view controller
       viewController?.present(messageController, animated: true, completion: nil)
   }
}

// Extend MessageSender to conform to the MFMessageComposeViewControllerDelegate protocol
extension MessageSender: MFMessageComposeViewControllerDelegate {
   // Implement the method that gets called when the user finishes composing a message
   func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
       // Handle the different possible results
       switch result {
       case .cancelled:
           print("Отправка сообщения отменена")
       case .sent:
           print("Сообщение успешно отправлено")
       case .failed:
           print("Ошибка отправки сообщения")
       @unknown default:
           fatalError("Непредвиденный результат отправки сообщения")
       }
       
       // Dismiss the message compose view controller
       controller.dismiss(animated: true, completion: nil)
   }
}
