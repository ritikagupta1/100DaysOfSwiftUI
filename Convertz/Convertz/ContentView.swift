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
    
    var correspondingUnit: UnitLength {
        switch self {
        case .meters:
            return .meters
        case .kilometers:
            return .kilometers
        case .feet:
            return .feet
        case .miles:
            return .miles
        }
    }
}



struct ContentView: View {
    @State var inputUnit: LengthUnits = .meters
    @State var outputUnit: LengthUnits = .meters
    
    @State var inputValue: Double = 0.0
    
    
    var convertedValue: Double {
        let inputValue = Measurement(value: inputValue , unit: inputUnit.correspondingUnit)
        
        return inputValue.converted(to: outputUnit.correspondingUnit).value
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
                    Text(convertedValue.formatted(.number.precision(.fractionLength(2))))
                }
            }
            .navigationTitle("Convert")
        }
    }
}

#Preview {
    ContentView()
}
