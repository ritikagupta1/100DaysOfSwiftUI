//
//  Binding.swift
//  ViewsAndModifiers
//
//  Created by Ritika Gupta on 07/02/25.
//

import SwiftUI

//struct BindingTestView: View {
//    @State private var selection = false
//    
//    var body: some View {
//            let binding = Binding(
//                get: { selection },
//                set: { selection = $0 }
//            )
//
//            return VStack {
//                Picker("Select a number", selection: binding) {
//                    ForEach(0..<3) {
//                        Text("Item \($0)")
//                    }
//                }
//                .pickerStyle(.segmented)
//            }
//        }
//}
//
//#Preview {
//    BindingTestView()
//}

struct CustomBinding: View {
    @State private var agreedToTerms = false
    @State private var agreedToPrivacyPolicy = false
    @State private var agreedToEmails = false

    var body: some View {
        let agreedToAll = Binding(
            get: {
                agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
            },
            set: {
                agreedToTerms = $0
                agreedToPrivacyPolicy = $0
                agreedToEmails = $0
            }
        )

        return VStack {
            Toggle("Agree to terms", isOn: $agreedToTerms)
            Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
            Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
            Toggle("Agree to all", isOn: agreedToAll)
        }
    }
}
