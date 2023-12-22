
import Foundation
import SwiftUI

// Define a SwiftUI View struct  LogiView
struct LoginView: View {
   // Declare State variables for name, password, error, login success status, and validation errors for name and password
   @State private var name: String = ""
   @State private var password: String = ""
   @State private var error: String? = nil
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   @State private var isLoginSuccessful = false
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
                  .background(Color(.systemGray6))
                  .cornerRadius(10)
                  .padding(.bottom, 20)

               // Create a SecureField for the password with similar styling to the username TextField
               SecureField("Password", text: $password)
                  .padding()
                  .background(Color(.systemGray6))
                  .cornerRadius(10)
                  .padding(.bottom, 20)

               // Create a Button that triggers the login process when pressed
               Button(action: {
                  // Check if the login was successful
                  isLoginSuccessful = LoginController.loginUser(name: name, password: password)
                  // If the login was not successful, set the error flags and colors
                  if !isLoginSuccessful {
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
                  // Style the login button
                  Text("Login")
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity)
                      .padding()
                      .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                      .cornerRadius(10)
               }

               // Create a NavigationLink that navigates to the registration view when pressed
               NavigationLink(destination: RegistrationView() ){
                  Text("Register")
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity)
                      .padding()
                      .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                      .cornerRadius(10)
               }
           }
           // Add padding around the VStack and set the navigation bar title to "Login"
           .padding()
           .navigationBarTitle("Login")
       }
       // Present the CreateRoomButtonView as a full screen cover when the login is successful
       .fullScreenCover(isPresented: $isLoginSuccessful) {
           CreateRoomButtonView()
       }
   }
}
