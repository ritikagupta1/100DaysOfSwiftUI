//
//  ContentView.swift
//  WordScramble
//
//  Created by Ritika Gupta on 21/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var isShowingError: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $isShowingError, actions: {
//                Button("Ok") {}
            }, message: {
                Text(errorMessage)
            })
            .navigationTitle(rootWord)
        }
    }
    
    func addNewWord() {
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard word.count > 0 else { return }
        
        guard isOriginal(word: word) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: word) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: word) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation {
            usedWords.insert(word, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWordsString = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWordsString.components(separatedBy: "\n")

                let randomWord = allWords.randomElement() ?? "silkworm"
                rootWord = randomWord
                return
            }
        }
        
        fatalError("Couldn't load start.txt file")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let wordChecker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledWordRange = wordChecker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledWordRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        isShowingError = true
    }
}

#Preview {
    ContentView()
}
