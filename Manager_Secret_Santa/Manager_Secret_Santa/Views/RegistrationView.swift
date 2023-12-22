
import Foundation
import SwiftUI

// Define a SwiftUI View struct RegistrationView
struct RegistrationView: View {
   // Declare State variables for name, password, registration success status, and validation errors for name and password
   @State private var name: String = ""
   @State private var password: String = ""
   @State var isRegSuccessful = false
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   @State private var nameError: Bool = false
   @State private var passwordError: Bool = false
   // Declare State variables for colors of name and password fields
   @State private var nameColor: Color = Color(.systemGray6)
   @State private var passwordColor: Color = Color(.systemGray6)

   // Define the body of the View
   var body: some View {
       // Create a NavigationView containing a VStack
       NavigationView {
           VStack {
               // Create a TextField for the username with padding, background color, corner radius, and bottom padding
               TextField("Username", text: $name)
                 .padding()
                 .background(nameColor)
                 .cornerRadius(10)
                 .padding(.bottom, 20)

               // Create a SecureField for the password with similar styling to the username TextField
               SecureField("Password", text: $password)
                 .padding()
                 .background(passwordColor)
                 .cornerRadius(10)
                 .padding(.bottom, 20)

               // Create a Button that triggers the registration process when pressed
               Button(action: {
                 // Check if the registration was successful
                 isRegSuccessful = RegistrationController.regUser(name: name, password: password)
                 // If the registration was not successful, set the error flags and colors
                 if !isRegSuccessful {
                     nameError = true
                     passwordError = true
                     // After a delay, reset the error flags and colors
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                         nameColor = Color.red.opacity(0.2)
                         passwordColor = Color.red.opacity(0.2)
                         nameError = false
                         passwordError = false
                         // Clear the username and password fields
                         name = ""
                         password = ""
                     }
                 }
               }) {
                 // Style the register button
                 Text("Register")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
               }
               // Create a Button that dismisses the registration view when pressed
               Button(action: {
                 // Dismiss the registration view
                 self.presentationMode.wrappedValue.dismiss()
               }) {
                 // Style the cancel button
                 Text("Cancel")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
               }
           }
       }
       // Present the CreateRoomButtonView as a full screen cover when the registration is successful
       .fullScreenCover(isPresented: $isRegSuccessful) {
           CreateRoomButtonView()
       }
   }
}
