//
//  Header.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/30/23.
//

import SwiftUI

struct Header: View {
    
    @Environment(\.presentationMode) var presentation
    
    let isLoggedIn: Bool = UserDefaults.standard.bool(forKey: kIsLoggedIn)
    
    var body: some View {
        HStack (alignment: .center) {
            Spacer()
            Image("Logo")
                .frame(alignment: .center)
            Spacer()
            Image(isLoggedIn ? "profile-image-placeholder" : "")
                .resizable()
                .frame(width: 50, height: 50, alignment: .trailing)
                .cornerRadius(20)
                .padding(10)
                
        }
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}

