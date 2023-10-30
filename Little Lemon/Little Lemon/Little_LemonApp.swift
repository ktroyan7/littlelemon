//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/28/23.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
