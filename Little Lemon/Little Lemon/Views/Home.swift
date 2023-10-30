//
//  Home.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/29/23.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    var body: some View {
        TabView {
            Menu()
                .tabItem{
                Label("Menu", systemImage: "list.dash")
            }.environment(\.managedObjectContext, persistence.container.viewContext)
            UserProfile()
                .tabItem{
                Label("Profile", systemImage: "square.and.pencil")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
