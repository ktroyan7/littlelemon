//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/29/23.
//

import SwiftUI

let kFirstName = "FirstNameKey"
let kLastName = "LastName"
let kEmail = "Email"
let kIsLoggedIn = "IsLoggedIn"

struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) { EmptyView() }
                    Header()
                    HeroSection()
                    Form {
                        Section(header: Text("Login Information")) {
                            Text("First Name*")
                            TextField("First Name", text: $firstName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("Last Name*")
                            TextField("Last Name", text: $lastName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("Email*")
                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.bottom)
                    Spacer()
                    Button {
                        print("clicked")
                        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
                            alertMessage = "Please enter all required fields"
                            showAlert.toggle()
                        } else {
                            isLoggedIn = true
                            saveProfile()
                        }
                    } label: {
                        Text("Register")
                            .foregroundColor(.black)
                            .frame(width: 0.7 * UIScreen.main.bounds.width, height: 50) // 70% of screen width
                            .background(Color(red: 241, green: 197, blue: 20)) // Yellow color (RGB values)
                            .cornerRadius(35) // Corner radius
                        
                    }
                    .alert(isPresented: $showAlert) { Alert(title: Text(alertMessage)) }
                    
                 }
                .onAppear() {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
            }
            

        }
        
     }
     
     fileprivate func saveProfile() {
         UserDefaults.standard.set(firstName, forKey: kFirstName)
         UserDefaults.standard.set(lastName, forKey: kLastName)
         UserDefaults.standard.set(email, forKey: kEmail)
         UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
     }
 }


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
