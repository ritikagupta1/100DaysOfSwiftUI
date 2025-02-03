//
//  ContentView.swift
//  Convertz
//
//  Created by Ritika Gupta on 03/02/25.
//

import SwiftUI

enum LengthUnits: String,CaseIterable {
    case meters = "m"
    case kilometers = "km"
    case feet = "feet"
    case miles = "miles"
}



struct ContentView: View {
    @State var inputUnit: LengthUnits = .meters
    @State var outputUnit: LengthUnits = .meters
    
    @State var inputValue: Double = 0.0
    
    
    var convertedValue: Double {
        var feetValue: Double
        switch inputUnit {
        case .meters:
            feetValue =  3.28084 * inputValue
        case .kilometers:
            feetValue =  3280.84 * inputValue
        case .feet:
            feetValue =   inputValue
        case .miles:
            feetValue =  5280  * inputValue
        }
        
        switch outputUnit {
        case .meters:
            return feetValue/3.28084
        case .kilometers:
            return feetValue/3280.84
        case .feet:
            return feetValue
        case .miles:
            return feetValue/5280
        }
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select Input Unit") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(LengthUnits.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Enter Input Value") {
                    TextField("Enter Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                
                Section("Select Output Unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(LengthUnits.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Converted Value") {
                    Text(convertedValue, format: .number)
                }
            }
            .navigationTitle("Convert")
        }
    }
}

#Preview {
    ContentView()
}
