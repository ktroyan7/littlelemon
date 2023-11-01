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
                .font(.title)
                .foregroundColor(.black)
            
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 3))
            
            Text("First Name: \(firstName)")
                .font(.headline)
            
            Text("Last Name: \(lastName)")
                .font(.headline)
            
            Text("Email: \(email)")
                .font(.headline)
            
            Button {
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .font(.headline)
                    .frame(width: 200, height: 40)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(20)
            }
        }
    }
}


struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
