//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ritika Gupta on 04/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    @State private var isShowingScore: Bool = false
    @State private var scoreTitle: String = ""
    
    @State private var score: Int = 0
    
    @State private var shouldRestartGame: Bool = false
    @State private var questionCount = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [.init(color: Color(red: 0.192, green: 0.173, blue: 0.318), location: 0.3),.init(color: Color(red: 0.941, green: 0.514, blue: 0.235) , location: 0.3)],
                center: .top,
                startRadius: 260,
                endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text("\(countries[correctAns])")
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            submitAnswer(number)
                        } label: {
                            FlagImageView(imageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score is \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $shouldRestartGame, actions: {
            Button("Restart") {
                self.restartGame()
            }
        }, message: {
            Text("Game over! You guessed \(score) out of 8 flags")
        })
        .alert(scoreTitle, isPresented: $isShowingScore) {
            Button("Continue") {
                self.askQuestion()
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    
    func submitAnswer(_ number: Int) {
        questionCount += 1
        if number == correctAns {
            scoreTitle = "Right Answer 🎊"
            score += 1
        } else {
            let wrongAns = countries[number]
            scoreTitle = "Wrong! That's the flag of \(wrongAns)"
        }
        
        if questionCount == 8 {
            shouldRestartGame = true
        } else {
            isShowingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAns = Int.random(in: 0...2)
    }
    
    func restartGame() {
        countries.shuffle()
        score = 0
        questionCount = 0
        shouldRestartGame = false
    }
}

#Preview {
    ContentView()
}

struct FlagImageView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 6)
    }
}
