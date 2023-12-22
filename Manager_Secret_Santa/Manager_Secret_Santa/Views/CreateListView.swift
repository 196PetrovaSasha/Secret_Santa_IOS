
import Foundation
import SwiftUI

// Define a SwiftUI View  CreateListView
struct CreateListView: View {
   // Declare State variables for participant list, room name, phone number, name, and instance of CreateListViewController
   @State private var prepareList: [(String, String)] = []
   @State public var roomname: String
   @State private var phoneNumber: String = ""
   @State private var name: String = ""
   var cr = CreateListViewController()

   // Define the body of the View
   var body: some View {
       VStack {
           // Display the room name
           Text(roomname)
               .font(.title)
               .padding()

           // Create a ScrollView to display the participant list
           ScrollView {
               ForEach(prepareList, id: \.0) { item in
                  Text(item.1)
                      .padding()
               }
           }

           // Create TextFields for the phone number and name
           TextField("Phone Number", text: $phoneNumber)
               .padding()
               .border(Color.gray, width: 0.5)

           TextField("Name", text: $name)
               .padding()
               .border(Color.gray, width: 0.5)

           // Create a Button that adds the new participant to the list when pressed
           Button(action: {
               // Check if the new participant data is valid
               if !CreateListViewController.addParticipant(participants: &prepareList, name: name, number: phoneNumber) {
                  // If the data is not valid, clear the TextFields
                  name = ""
                  phoneNumber = ""
               }
           }) {
               // Style the save button
               Text("Save")
                  .font(.title)
                  .padding()
                  .frame(maxWidth: .infinity)
                  .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                  .foregroundColor(.white)
                  .cornerRadius(10)
           }

           // Add spacers for layout
           Spacer()
           Spacer()
           Spacer()

           // Create a Button that starts the lottery when pressed
           Button(action: {
               // Start the lottery with the current participants and room name
               cr.startLotery(participants: prepareList, roomname: roomname)
           }) {
               // Style the start lottery button
               Text("Start Lottery")
                  .font(.title)
                  .padding()
                  .frame(maxWidth: .infinity)
                  .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                  .foregroundColor(.white)
                  .cornerRadius(10)
           }
       }
       // Add padding around the VStack
       .padding()
   }
}
