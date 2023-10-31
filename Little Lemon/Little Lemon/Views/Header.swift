//
//  Header.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/30/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack (alignment: .center) {
            Spacer()
            Image("Logo")
                .frame(alignment: .center)
            Spacer()
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 50, height: 50, alignment: .trailing)
                .cornerRadius(10)
                .padding(.trailing, 20)
                
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}

