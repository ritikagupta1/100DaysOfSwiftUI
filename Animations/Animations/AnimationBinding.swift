//
//  AnimationBinding.swift
//  Animations
//
//  Created by Ritika Gupta on 24/02/25.
//

import SwiftUI

struct AnimationBinding: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        print(animationAmount)
        return VStack {
            Stepper("Scale Amount", value: $animationAmount.animation(.easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true))
                    , in: 1...10)
            
            Spacer()
            
            Button("Tap me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
//            .animation(.easeInOut(duration: 1)
//                .delay(1), value: animationAmount)
        }
    }
}

#Preview {
    AnimationBinding()
}
