
import Foundation
import SwiftUI
import MessageUI


// Define a CreateListViewController class that inherits from UIViewController
public class CreateListViewController : UIViewController {
   
   // Instance of MessageSender for sending messages
   let messageSender = MessageSender()

   // Override the viewDidLoad method
   public override func viewDidLoad() {
       super.viewDidLoad()
       // Assign the view controller to the message sender
       messageSender.viewController = self
   }

   // Method to add a participant to the list
   public static func addParticipant(participants: inout [(String, String)], name: String, number: String) -> Bool {
       // Check if the participant list already contains a participant with the same name
       if participants.contains(where: { $0.1 == name }) {
           return false
       }
       // Validate the phone number using a regular expression
       let pattern = "^(\\+7|8)[0-9]{10}$"
       let regex = try? NSRegularExpression(pattern: pattern)
       let range = NSRange(location: 0, length: number.utf16.count)
       if let match = regex?.firstMatch(in: number, options: [], range: range) {
           // If the phone number is valid, add the participant to the list
           if match.range.length > 0 {
               participants.append((number, name))
           }
       }
       // Return false to indicate that the participant could not be added
       return false
   }

   // Method to find a participant by phone number
   public static func searchByNumber(number: String, participants: [(String, String)]) -> String {
       // Iterate over the participants
       for part in participants {
           // If the phone number matches, return the participant's name
           if number == part.0 {
               return part.1
           }
       }
       // If no matching participant is found, return an empty string
       return ""
   }

   // Method to start the lottery
   public func startLotery(participants: [(String, String)], roomname: String) {
       // Print a message indicating that the lottery has started
       print("lot started")
       // Initialize an array to store the pairs of participants
       var resultPairs = [(String, String)]()
       // Initialize an array to store the remaining participants
       var remainingParticipants = participants.map { $0.0 }

       // Iterate over the participants
       for participant in participants {
           // Select a random participant from the remaining participants
           let index = Int.random(in: 0..<remainingParticipants.count)
           let partner = remainingParticipants[index]

           // Remove the selected participant from the remaining participants
           remainingParticipants.remove(at: index)

           // Add the pair to the result pairs
           let pair = (participant.0, partner)
           resultPairs.append(pair)
       }

       // Print the results of the draw
       print("Результаты жеребьевки для комнаты \(roomname):")
       for pair in resultPairs {
           print("\(pair.0) - \(pair.1)")
       }

       // Send messages to the participants informing them about their partners
       for pair in resultPairs {
           let recipients = pair.0
           let name = CreateListViewController.searchByNumber(number: recipients, participants: participants)
           let body = "Привет)) Ты учавствуешь в игре тайный санта в комнате \(roomname), тебе выпал игрок \(name). Хорошей игры!"

           // Use the message sender to send the message
           self.messageSender.sendMessage(recipients: [recipients], body: body)
       }
   }
}
