//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Ritika Gupta on 07/02/25.
//

import SwiftUI

enum MoveOptions: String, CaseIterable {
    case rock = "🪨"
    case paper = "📄"
    case scissor = "✂️"
    
    var winMove: MoveOptions {
        switch self {
        case .rock:
              return .paper
        case .paper:
            return  .scissor
        case .scissor:
            return .rock
        }
    }
    
    var loseMove: MoveOptions {
        switch self {
        case .rock:
            return .scissor
        case .paper:
            return .rock
        case .scissor:
            return .paper
        }
    }
}


struct ContentView: View {
    @State private var givenMove: MoveOptions = MoveOptions.allCases.randomElement() ?? .rock
    
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    
    @State private var scoreTitle: String = ""
    
    @State private var isShowingScore: Bool = false
    
    @State private var roundNumber = 0
    
    @State private var shouldRestartGame = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple,.indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text(givenMove.rawValue)
                            .font(.system(size: 140))
                            .frame(width: 220, height: 220)
                            .background(.thinMaterial)
                            .clipShape(.rect(cornerRadius: 14))
                            .shadow(radius: 10)
                        
                        Text(shouldWin ? "Choose your winning move" : "Choose your losing move")
                            .font(.title)
                            .bold()
                            .foregroundStyle(shouldWin ? .green : .red)
                            .padding()
                            
                    }.padding(.top, 30)
                    
                    HStack(spacing: 20) {
                        ForEach(MoveOptions.allCases, id: \.self) { move in
                            Button {
                                submitAns(move: move)
                            } label: {
                                Text(move.rawValue)
                                    .font(.system(size: 80))
                                    .padding()
                                    .background(.thinMaterial)
                                    .clipShape(.rect(cornerRadius: 14))
                                    .shadow(radius: 10)
                            }
                        }
                    }
                    .padding()
                
                    Spacer()
                    
                    Text("Score is \(score)")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            .navigationTitle("Rock Paper Scissors")
            .alert(scoreTitle, isPresented: $shouldRestartGame, actions: {
                Button("Restart") {
                    self.restartGame()
                }
            }, message: {
                Text("Game over! You scored \(score) out of 10")
            })
            .alert(scoreTitle, isPresented: $isShowingScore) {
                Button("Continue") {
                    next()
                }
            } message: {
                Text("Score is \(score)")
            }
        }
    }
    
    func submitAns(move: MoveOptions) {
        roundNumber += 1
        let correctMove = shouldWin ? givenMove.winMove : givenMove.loseMove
        if move == correctMove {
            scoreTitle = "Right Answer 🎊"
            score += 1
        } else {
            scoreTitle = "Incorrect🫠. Try again next round!"
            score -= 1
        }
        if roundNumber == 10 {
            shouldRestartGame = true
        } else {
            isShowingScore = true
        }
    }
    
    func restartGame() {
        score = 0
        roundNumber = 0
        next()
    }
    
    func next() {
        givenMove = MoveOptions.allCases.randomElement() ?? .rock
        shouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
