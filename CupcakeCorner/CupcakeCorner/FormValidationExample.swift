//
//  FormValidationExample.swift
//  CupcakeCorner
//
//  Created by Dave Spina on 12/26/20.
//

import SwiftUI

struct FormValidationExample: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableButton: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create Account") {
                    print("Creating Account...")
                }
            }.disabled(disableButton)
        }
    }
}

struct FormValidationExample_Previews: PreviewProvider {
    static var previews: some View {
        FormValidationExample()
    }
}
