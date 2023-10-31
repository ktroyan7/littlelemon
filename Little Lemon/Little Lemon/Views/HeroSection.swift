//
//  HeroSection.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/31/23.
//

import SwiftUI

struct HeroSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Little Lemon")
                .foregroundColor(Color(red: 241, green: 197, blue: 20))
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.top, 8)
            HStack{
                VStack(alignment: .leading) {
                    Text("New York")
                        .font(.title)
                        .padding(.bottom, 2)
                    Text("Family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                }
                Spacer()
                Image("Hero image")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(25)
            }
        }
        .padding(8)
        .foregroundColor(.white)
        .background(Color(red: 57, green: 76, blue: 69))
    }
}

struct HeroSection_Previews: PreviewProvider {
    static var previews: some View {
        HeroSection()
    }
}
