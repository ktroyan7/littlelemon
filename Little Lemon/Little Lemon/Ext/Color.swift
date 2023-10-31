//
//  Color.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/31/23.
//

import Foundation
import SwiftUI

extension Color {
    init(red: Int, green: Int, blue: Int) {
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
    }
}
