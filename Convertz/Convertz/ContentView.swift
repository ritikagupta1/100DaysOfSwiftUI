//
//  ContentView.swift
//  Convertz
//
//  Created by Ritika Gupta on 03/02/25.
//

import SwiftUI

protocol Unit{
    var correspondingUnit: Dimension { get }
}


enum AnyUnit: Unit, Hashable {
    var correspondingUnit: Dimension {
        switch self {
        case .temperature(let unit):
            return unit.correspondingUnit
        case .length(let unit):
            return unit.correspondingUnit
        case .volume(unit: let unit):
            return unit.correspondingUnit
        case .time(unit: let unit):
            return unit.correspondingUnit
        }
    }
    
    var rawValue: String {
        switch self {
        case .temperature(let unit):
            return unit.rawValue
        case .length(let unit):
            return unit.rawValue
        case .volume(let unit):
            return unit.rawValue
        case .time(let unit):
            return unit.rawValue
        }
    }
    
    case temperature(unit: TemperatureUnits)
    case length(unit: LengthUnits)
    case volume(unit: VolumeUnits)
    case time(unit: TimeUnits)
}

enum TemperatureUnits: String,CaseIterable {
    case celsius
    case fahrenheit
    case kelvin
    
    var correspondingUnit: Dimension {
        switch self {
        case .celsius:
            return  UnitTemperature.celsius
        case .fahrenheit:
            return  UnitTemperature.fahrenheit
        case .kelvin:
            return  UnitTemperature.kelvin
        }
    }
}

enum LengthUnits: String,CaseIterable{
    case meters = "m"
    case kilometers = "km"
    case feet = "feet"
    case miles = "miles"
    
    
    var correspondingUnit: Dimension {
        switch self {
        case .meters:
            return UnitLength.meters
        case .kilometers:
            return UnitLength.kilometers
        case .feet:
            return UnitLength.feet
        case .miles:
            return UnitLength.miles
        }
    }
}

enum VolumeUnits: String,CaseIterable{
    case milliliters = "ml"
    case liters = "ltr"
    case cups
    case pints
    case gallons
    
    var correspondingUnit: Dimension {
        switch self {
        case .milliliters:
            UnitVolume.milliliters
        case .liters:
            UnitVolume.liters
        case .cups:
            UnitVolume.cups
        case .pints:
            UnitVolume.pints
        case .gallons:
            UnitVolume.gallons
        }
    }
}

enum TimeUnits: String,CaseIterable{
    case seconds
    case minutes
    case hours
    
    var correspondingUnit: Dimension {
        switch self {
        case .seconds:
            UnitDuration.seconds
        case .minutes:
            UnitDuration.minutes
        case .hours:
            UnitDuration.hours
        }
    }
}


enum ConversionType: String,CaseIterable {
    case temperature = "Temp 🌡️"
    case length = "Length 🦯"
    case volume = "Volume 🟫"
    case time = "Time 🕰️"
}


struct ContentView: View {
    @State private var conversionType: ConversionType = .temperature
    
    @State private var inputUnit: AnyUnit = .temperature(unit: .celsius)
    @State private var outputUnit: AnyUnit = .temperature(unit: .celsius)
    
    @State private var inputValue: Double = 0.0
    
    @FocusState private var isTextFieldFocussed: Bool
    
    var choices: [AnyUnit] {
        switch conversionType {
        case .temperature:
            return TemperatureUnits.allCases.map { AnyUnit.temperature(unit: $0)
            }
        case .length:
            return LengthUnits.allCases.map { AnyUnit.length(unit: $0)
            }
        case .volume:
            return VolumeUnits.allCases.map { AnyUnit.volume(unit: $0)
            }
        case .time:
            return TimeUnits.allCases.map { AnyUnit.time(unit: $0)
            }
        }
    }


    var convertedValue: Double {
        let inputValue = Measurement(value: inputValue , unit: inputUnit.correspondingUnit)
        
        return inputValue.converted(to: outputUnit.correspondingUnit).value
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select Conversion Type") {
                    Picker("Conversion Type", selection: $conversionType) {
                        ForEach(ConversionType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                        .onChange(of: conversionType) { oldValue, newValue in
                            switch newValue {
                            case .temperature:
                                inputUnit = .temperature(unit: .celsius)
                                outputUnit = .temperature(unit: .celsius)
                            case .length:
                                inputUnit = .length(unit: .meters)
                                outputUnit = .length(unit: .meters)
                            case .volume:
                                inputUnit = .volume(unit: .milliliters)
                                outputUnit = .volume(unit: .milliliters)
                            case .time:
                                inputUnit = .time(unit: .seconds)
                                outputUnit = .time(unit: .seconds)
                            }
                        }
                        .tint(Color.green)
                        
                }
              
                Section("Select Input Unit") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(choices, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }
              
                Section("Enter Input Value") {
                    TextField("Enter Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isTextFieldFocussed)
                }
              
                Section("Select Output Unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(choices, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Converted Value") {
                    Text(convertedValue.formatted(.number.precision(.fractionLength(2))))
                }
            }.toolbar {
                if isTextFieldFocussed {
                    Button("Done") {
                        
                        isTextFieldFocussed = false
                    }
                }
            }
            .navigationTitle("Convert")        }
    }
}

#Preview {
    ContentView()
}
