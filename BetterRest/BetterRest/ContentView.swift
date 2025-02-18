//
//  ContentView.swift
//  BetterRest
//
//  Created by Ritika Gupta on 18/02/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeUpTime
    @State private var sleepHours = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isShowingAlert: Bool = false
    
    
    static private var defaultWakeUpTime: Date {
        get {
            var component = DateComponents()
            component.hour = 7
            component.minute = 0
            return Calendar.current.date(from: component) ?? .now
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("What time would you like to wake up?")
                        .font(.headline)
                    
                    DatePicker("Select Wakeup Time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepHours.formatted()) hours", value: $sleepHours, in: 4...12, step: 0.25)
                    
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily Coffee Intake")
                        .font(.headline)
                    // Pluralise according to coffeeAmount
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                }
            }
            .toolbar {
                Button {
                    calculateSleep()
                } label: {
                    Text("Calculate Sleep")
                }
            }
            .alert(alertTitle, isPresented: $isShowingAlert, actions: {
                Button("Ok") {}
            }, message: {
                Text(alertMessage)
            })
            .navigationTitle("Better Rest")
        }
    }
    
    func calculateSleep() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = components.hour ?? 0 * 60 * 60
            let minutes = components.minute ?? 0 * 60
            
            let wakeUpTimeInSeconds = (hour + minutes)
            
            let prediction = try model.prediction(wake: Double(wakeUpTimeInSeconds), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let bedTime = wakeUpTime - prediction.actualSleep
            alertTitle = "You need to go to bed at.."
            alertMessage = bedTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, Prediction failed"
        }
        isShowingAlert = true
    }
}

#Preview {
    ContentView()
}
