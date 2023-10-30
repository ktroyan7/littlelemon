//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/29/23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? "First Name not provided"
    let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? "Last name not provided"
    let email: String = UserDefaults.standard.string(forKey: kEmail) ?? "Email not provided"
    
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 100, height: 150)
            Text("\(firstName)")
            Text("\(lastName)")
            Text("\(email)")
            Button {
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
            }

                
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
