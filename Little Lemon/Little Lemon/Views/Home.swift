//
//  Home.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/29/23.
//

import SwiftUI

struct Home: View {
    
    @Binding var isLoggedIn: Bool
    
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu(isLoggedIn: $isLoggedIn)
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
            UserProfile()
                .tabItem({
                    Label("Profile", systemImage: "square.and.pencil")
                })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(isLoggedIn: .constant(true))
    }
}
