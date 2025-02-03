//
//  ContentView.swift
//  WeSplit
//
//  Created by Ritika Gupta on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    
    @FocusState private var amountIsFocussed: Bool
    
    var tipPercentageOptions: [Int] = [0,10,15,20]
    
    var totalAmount: Double {
        let tipSelection: Double = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelection
        return checkAmount + tipAmount
    }
    var totalPerPerson: Double {
        let numberOfPersons = Double(numberOfPeople + 2)
        return totalAmount/numberOfPersons
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocussed)
                    
                    Picker("Number of People",
                           selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip Amount", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Total Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .toolbar {
                //                ToolbarItem(placement: .keyboard) {
                if amountIsFocussed {
                    Button {
                        amountIsFocussed = false
                    } label: {
                        Text("Done")
                    }
                }
                
                //                }
            }
            .navigationTitle("WeSplit")
        }
        
    }
}

#Preview {
    ContentView()
}
