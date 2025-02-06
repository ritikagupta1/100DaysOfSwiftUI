//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ritika Gupta on 06/02/25.
//

import SwiftUI
struct GridStack<Content: View> : View {
    var row: Int
    var column: Int
    @ViewBuilder var content: (Int,Int) -> Content
    
    var body: some View {
        VStack{
            ForEach(0..<row, id: \.self) { row in
                HStack {
                    ForEach(0..<column, id: \.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        GridStack(row: 4, column: 3) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("\(row), \(col)")
        }
    }
}

#Preview {
    ContentView()
}

