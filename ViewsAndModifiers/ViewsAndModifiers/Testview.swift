//
//  Testview.swift
//  ViewsAndModifiers
//
//  Created by Ritika Gupta on 06/02/25.
//

import SwiftUI

struct Testview: View {
    var body: some View {
        Text("hello")
        Image(systemName: "1.circle")
    }
}

#Preview {
    Testview()
}

struct blueTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func blueTitle() -> some View {
        self.modifier(blueTitleModifier())
    }
}
