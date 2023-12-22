
import Foundation
import SwiftUI

// Define a SwiftUI View struct CreateRoomButtonView
struct CreateRoomButtonView: View {
  // Declare State variables for room name input and navigation link activation status
  @State private var textFieldContent = ""
  @State private var isNavigationLinkActive = false

  // Define the body of the View
  var body: some View {
      // Create a NavigationView containing a VStack
      NavigationView {
          VStack {
              // Create a TextField for the room name with padding and border
              TextField("room name", text: $textFieldContent)
                .padding()
                .border(Color.gray, width: 0.5)

              // Create a Button that triggers the creation of a new room when pressed
              Button(action: {
                // Check if the room name is not empty
                if !textFieldContent.isEmpty {
                 isNavigationLinkActive = true
                }
              }) {
                // Style the create room button
                Text("Create Room")
                 .font(.largeTitle)
                 .bold()
                 .foregroundColor(.white)
                 .padding()
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                 .clipShape(Circle())
                 .padding(30)
              }

              // Create a NavigationLink that navigates to the CreateListView when the button is pressed
              NavigationLink(destination: CreateListView(roomname: textFieldContent), isActive: $isNavigationLinkActive) {
                 EmptyView()
              }
          }
      }
  }
}
