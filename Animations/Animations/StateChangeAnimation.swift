//
//  StateChangeAnimation.swift
//  Animations
//
//  Created by Ritika Gupta on 24/02/25.
//

import SwiftUI

struct StateChangeAnimation: View {
    @State private var animationAmount = 0.0
    var body: some View {
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.8)) {
                animationAmount += 360.0
            }
            
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
    }
}

#Preview {
    StateChangeAnimation()
}
