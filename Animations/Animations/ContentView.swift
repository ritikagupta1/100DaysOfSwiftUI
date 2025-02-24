//
//  ContentView.swift
//  Animations
//
//  Created by Ritika Gupta on 24/02/25.
//

import SwiftUI

struct ImplicitAnimation: View {
    @State var animationAmount: Double = 1.0
    var body: some View {
        Button("Tap Me") {
           
        }
        .padding(50)
        .background(Color.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
        .overlay {
            Circle()
                .stroke(.blue)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 2)
                    .repeatForever(autoreverses: false),
                    value: animationAmount)
        }
       
        .onAppear{
            animationAmount += 1
        }
        
    }
}

#Preview {
    ImplicitAnimation()
}
