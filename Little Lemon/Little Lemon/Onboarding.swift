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
        
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) { EmptyView() }
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
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
                }
                 .padding()
                 .alert(isPresented: $showAlert) {
                     Alert(title: Text(alertMessage))
                 }
             }
            .onAppear() {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
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
